import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:image/image.dart' as img;

/// Formats voter slip for thermal printer
/// Combines: image + section1_text + voter info + section3_text
class ThermalSlipFormatter {
  static const int _charsPerLine = 32; // 48mm / ~1.5mm per char

  /// Format slip content: image (if provided) + section1 + voter info + section3
  static String formatSlipContent({
    required String section1,
    required Voter voter,
    required String section3,
    required String langCode,
    String? boothName,
    String? imageMarker, // Placeholder for image (will be handled separately)
  }) {
    final buffer = StringBuffer();

    // Section 0 (Image marker/placeholder - actual image will be inserted before text)
    if (imageMarker != null && imageMarker.isNotEmpty) {
      buffer.writeln('[IMAGE]'); // Marker for image insertion
      buffer.writeln();
    }

    // Section 1 (Header)
    if (section1.isNotEmpty) {
      buffer.writeln(section1);
      buffer.writeln();
    }

    // Section 2 (Voter Information)
    final voterName = langCode == 'en'
        ? (voter.name ?? 'N/A')
        : (voter.nameLocal ?? voter.name ?? 'N/A');

    final epicId = voter.epicId ?? 'N/A';
    final serialNo = voter.serialNumber?.toString() ?? 'N/A';
    final booth = boothName ?? voter.sectionName ?? 'N/A';

    buffer.writeln('Name: $voterName');
    buffer.writeln('EPIC ID: $epicId');
    buffer.writeln('Serial No: $serialNo');
    buffer.writeln('Booth: $booth');

    // Section 3 (Footer)
    if (section3.isNotEmpty) {
      buffer.writeln();
      buffer.writeln();
      buffer.writeln(section3);
    }

    return buffer.toString();
  }

  /// Generate ESC/POS thermal commands for printing text content
  static List<int> generateESCPOSCommands(String content) {
    final commands = <int>[];

    // Initialize printer
    commands.addAll(_initializePrinter());

    // Convert content to bytes
    commands.addAll(content.codeUnits.toList());

    // Line feeds and cut
    commands.addAll([0x0A, 0x0A]); // Two line feeds
    commands.addAll(_cutPaper());

    return commands;
  }

  /// Generate ESC/POS commands with image data
  /// Image is printed first, followed by text content
  /// If text contains non-ASCII (e.g., Telugu), render text as image too
  static Future<List<int>> generateESCPOSCommandsWithImage({
    required String textContent,
    Uint8List? imageData,
  }) async {
    final commands = <int>[];

    // Initialize printer
    commands.addAll(_initializePrinter());

    // Print header image if provided
    if (imageData != null && imageData.isNotEmpty) {
      try {
        // Print image using ESC/POS image commands
        commands.addAll(_printImageCommand(imageData));
        commands.addAll([0x0A, 0x0A, 0x0A]); // Three line feeds after image for spacing
      } catch (e) {
        debugPrint('Error adding image to print: $e');
      }
    }

    // Print text content
    // Remove [IMAGE] marker if present
    final cleanContent = textContent.replaceAll('[IMAGE]\n\n', '');
    
    // Check if text contains non-ASCII characters (e.g., Telugu)
    if (_containsNonASCII(cleanContent)) {
      // Render text as image for non-ASCII characters
      try {
        final textImageData = await _renderTextAsImage(cleanContent);
        if (textImageData != null) {
          commands.addAll(_printImageCommand(textImageData));
        }
      } catch (e) {
        debugPrint('Error rendering text as image: $e');
        // Fallback to sending raw bytes (will show gibberish but won't crash)
        commands.addAll(cleanContent.codeUnits.toList());
      }
    } else {
      // For ASCII text, use enhanced formatting
      commands.addAll(_formatASCIIText(cleanContent));
    }

    // Line feeds and cut
    commands.addAll([0x0A, 0x0A, 0x0A]); // Three line feeds before cut
    commands.addAll(_cutPaper());

    return commands;
  }

  /// Format ASCII text with ESC/POS commands for better quality
  static List<int> _formatASCIIText(String text) {
    final commands = <int>[];
    final lines = text.split('\n');
    
    for (final line in lines) {
      if (line.trim().isEmpty) {
        commands.add(0x0A); // Line feed for empty lines
        continue;
      }
      
      // Check if line is a header/label (contains colon or is emphasized)
      final isLabel = line.contains(':');
      
      if (isLabel) {
        // Make labels bold
        commands.addAll(_setBold(true));
        commands.addAll(line.codeUnits);
        commands.addAll(_setBold(false));
      } else {
        // Normal text
        commands.addAll(line.codeUnits);
      }
      
      commands.add(0x0A); // Line feed
    }
    
    return commands;
  }

  /// ESC/POS: Set bold text
  static List<int> _setBold(bool enable) {
    return [0x1B, 0x45, enable ? 0x01 : 0x00]; // ESC E n
  }

  /// Check if text contains non-ASCII characters
  static bool _containsNonASCII(String text) {
    for (int i = 0; i < text.length; i++) {
      if (text.codeUnitAt(i) > 127) {
        return true;
      }
    }
    return false;
  }

  /// Render text as an image using Flutter's painting APIs with enhanced quality
  static Future<Uint8List?> _renderTextAsImage(String text) async {
    try {
      const printerWidth = 384; // 48mm thermal printer
      const double fontSize = 20.0; // Increased from 16
      const double padding = 12.0; // Increased padding
      const double lineHeight = 1.6; // Better spacing

      // Split text into sections for better formatting
      final lines = text.split('\n');
      final List<TextSpan> spans = [];

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        
        // Detect headers/important lines (all caps, or containing keywords)
        final isHeader = line.toUpperCase() == line && line.length > 3 ||
                        line.contains(':') && !line.startsWith(' ');
        
        spans.add(TextSpan(
          text: line + (i < lines.length - 1 ? '\n' : ''),
          style: TextStyle(
            color: Colors.black,
            fontSize: isHeader ? fontSize + 2 : fontSize,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
            height: lineHeight,
            letterSpacing: 0.3,
          ),
        ));
      }

      final textSpan = TextSpan(children: spans);

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: null,
      );

      // Layout the text with printer width constraints
      textPainter.layout(maxWidth: printerWidth - (padding * 2));

      final imageWidth = printerWidth;
      final imageHeight = (textPainter.height + (padding * 2)).toInt();

      // Create a picture recorder to draw the text at higher quality
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Fill background with white
      final paint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, imageWidth.toDouble(), imageHeight.toDouble()),
        paint,
      );

      // Draw the text
      textPainter.paint(canvas, Offset(padding, padding));

      // Convert to image at higher quality
      final picture = recorder.endRecording();
      final img = await picture.toImage(imageWidth, imageHeight);
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        return null;
      }

      return byteData.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error rendering text as image: $e');
      return null;
    }
  }

  /// Convert image data to ESC/POS graphics command with enhanced quality
  /// Resizes image to 384px width and converts to monochrome bitmap using Floyd-Steinberg dithering
  static List<int> _printImageCommand(Uint8List imageData) {
    try {
      // Decode the image
      img.Image? image = img.decodeImage(imageData);
      if (image == null) {
        debugPrint('Failed to decode image');
        return [];
      }

      // Resize image to printer width (384 dots for 48mm thermal printer)
      const printerWidth = 384;
      final aspectRatio = image.height / image.width;
      final targetHeight = (printerWidth * aspectRatio).round();
      
      // Use cubic interpolation for better quality
      image = img.copyResize(
        image,
        width: printerWidth,
        height: targetHeight,
        interpolation: img.Interpolation.cubic,
      );

      // Convert to grayscale
      image = img.grayscale(image);
      
      // Increase contrast for better print quality
      image = img.contrast(image, contrast: 120);
      image = img.adjustColor(image, brightness: 1.1);

      final width = image.width;
      final height = image.height;
      final bytesPerRow = (width + 7) ~/ 8; // Round up to nearest byte

      // Apply Floyd-Steinberg dithering for better image quality
      final ditheredImage = _applyFloydSteinbergDithering(image);

      // Create bitmap data from dithered image
      final bitmapData = <int>[];
      
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < bytesPerRow; x++) {
          int byte = 0;
          for (int bit = 0; bit < 8; bit++) {
            final pixelX = x * 8 + bit;
            if (pixelX < width) {
              // Use dithered value (0 or 255)
              final pixelValue = ditheredImage[y * width + pixelX];
              // Invert: 0 = white (no print), 1 = black (print)
              if (pixelValue < 128) {
                byte |= 1 << (7 - bit);
              }
            }
          }
          bitmapData.add(byte);
        }
      }

      // Generate ESC/POS GS v 0 command
      final commands = <int>[];
      
      // GS v 0 m xL xH yL yH d1...dk
      commands.add(0x1D); // GS
      commands.add(0x76); // v
      commands.add(0x30); // 0
      commands.add(0x00); // m (normal mode)
      
      // Width in bytes (xL, xH)
      commands.add(bytesPerRow & 0xFF); // xL
      commands.add((bytesPerRow >> 8) & 0xFF); // xH
      
      // Height in dots (yL, yH)
      commands.add(height & 0xFF); // yL
      commands.add((height >> 8) & 0xFF); // yH
      
      // Add bitmap data
      commands.addAll(bitmapData);

      return commands;
    } catch (e) {
      debugPrint('Error converting image to ESC/POS: $e');
      return [];
    }
  }

  /// Apply Floyd-Steinberg dithering for better image quality
  /// Returns a flattened array of grayscale values (0 or 255)
  static List<int> _applyFloydSteinbergDithering(img.Image image) {
    final width = image.width;
    final height = image.height;
    
    // Create a mutable copy of pixel values
    final pixels = List<int>.filled(width * height, 0);
    
    // Copy grayscale values
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final pixel = image.getPixel(x, y);
        final luminance = img.getLuminanceRgb(pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt());
        pixels[y * width + x] = luminance.round();
      }
    }

    // Apply Floyd-Steinberg dithering
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final idx = y * width + x;
        final oldPixel = pixels[idx];
        final newPixel = oldPixel < 128 ? 0 : 255;
        pixels[idx] = newPixel;
        
        final error = oldPixel - newPixel;
        
        // Distribute error to neighboring pixels
        if (x + 1 < width) {
          pixels[idx + 1] = (pixels[idx + 1] + error * 7 / 16).round().clamp(0, 255);
        }
        if (y + 1 < height) {
          if (x > 0) {
            pixels[idx + width - 1] = (pixels[idx + width - 1] + error * 3 / 16).round().clamp(0, 255);
          }
          pixels[idx + width] = (pixels[idx + width] + error * 5 / 16).round().clamp(0, 255);
          if (x + 1 < width) {
            pixels[idx + width + 1] = (pixels[idx + width + 1] + error * 1 / 16).round().clamp(0, 255);
          }
        }
      }
    }

    return pixels;
  }

  /// ESC/POS: Initialize printer
  static List<int> _initializePrinter() {
    return [0x1B, 0x40]; // ESC @
  }

  /// ESC/POS: Cut paper
  static List<int> _cutPaper() {
    return [0x1D, 0x56, 0x01]; // GS V m (partial cut)
  }
}
