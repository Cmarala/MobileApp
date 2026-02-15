import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Data model for Bluetooth printer device
class PrinterDevice {
  final String name;
  final String address;

  PrinterDevice({
    required this.name,
    required this.address,
  });

  @override
  String toString() => '$name ($address)';
}

/// Manages thermal printer connection via platform channel
class PrinterService extends ChangeNotifier {
  static final PrinterService _instance = PrinterService._internal();

  factory PrinterService() {
    return _instance;
  }

  PrinterService._internal();

  static const MethodChannel _channel = MethodChannel('com.example.mobileapp/printer');

  bool _isConnected = false;
  List<PrinterDevice> _devices = [];
  PrinterDevice? _selectedDevice;

  bool get isConnected => _isConnected;
  List<PrinterDevice> get devices => _devices;
  PrinterDevice? get selectedDevice => _selectedDevice;

  /// Get available Bluetooth devices
  Future<List<PrinterDevice>> getAvailableDevices() async {
    try {
      final List<dynamic> devices =
          await _channel.invokeMethod('getBondedDevices') as List<dynamic>;

      _devices = devices.whereType<Map>().map((device) {
        return PrinterDevice(
          name: device['name'] as String? ?? 'Unknown',
          address: device['address'] as String? ?? '',
        );
      }).toList();

      notifyListeners();
      // Return typed PrinterDevice objects
      return _devices;
    } catch (e) {
      debugPrint('Error getting devices: $e');
      return [];
    }
  }

  /// Connect to selected printer
  Future<bool> connectToDevice(PrinterDevice device) async {
    try {
      // Extract address from device object
      final address = device.address;
      final name = device.name;
      
      final result = await _channel.invokeMethod<bool>(
        'connect',
        {'address': address},
      );

      if (result == true) {
        _selectedDevice = PrinterDevice(name: name, address: address);
        _isConnected = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error connecting: $e');
      return false;
    }
  }

  /// Disconnect from printer
  Future<void> disconnect() async {
    try {
      await _channel.invokeMethod('disconnect');
      _isConnected = false;
      _selectedDevice = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error disconnecting: $e');
    }
  }

  /// Check if printer is connected
  Future<bool> isConnectedToPrinter() async {
    try {
      final connected =
          await _channel.invokeMethod<bool>('isConnected') ?? false;
      _isConnected = connected;
      notifyListeners();
      return _isConnected;
    } catch (e) {
      _isConnected = false;
      notifyListeners();
      return false;
    }
  }

  /// Print text content
  Future<bool> printText(String text) async {
    if (!_isConnected) {
      throw Exception('Printer not connected');
    }

    try {
      final result = await _channel.invokeMethod<bool>(
        'printText',
        {'text': text},
      );
      return result ?? false;
    } catch (e) {
      debugPrint('Error printing text: $e');
      rethrow;
    }
  }

  /// Print bytes (ESC/POS commands)
  Future<bool> printBytes(List<int> bytes) async {
    if (!_isConnected) {
      throw Exception('Printer not connected');
    }

    try {
      final result = await _channel.invokeMethod<bool>(
        'printBytes',
        {'bytes': bytes},
      );
      return result ?? false;
    } catch (e) {
      debugPrint('Error printing bytes: $e');
      rethrow;
    }
  }
}
