import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:mobileapp/utils/printer_service.dart';
import '../models/settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {
  final SharedPreferences _prefs;

  // Keys for SharedPreferences
  static const _langKey = 'selected_language_code';
  static const _headerTextEnabledKey = 'headerTextEnabled';
  static const _headerImageEnabledKey = 'headerImageEnabled';
  static const _footerEnabledKey = 'footerEnabled';
  static const _printerAddressKey = 'connectedPrinterAddress';
  static const _printerNameKey = 'connectedPrinterName';

  SettingsController(this._prefs)
      : super(SettingsState(
          langCode: _prefs.getString(_langKey) ?? 'en', // Default to English
          headerTextEnabled: _prefs.getBool(_headerTextEnabledKey) ?? true,
          headerImageEnabled: _prefs.getBool(_headerImageEnabledKey) ?? true,
          footerEnabled: _prefs.getBool(_footerEnabledKey) ?? true,
          connectedPrinterAddress: _prefs.getString(_printerAddressKey),
          connectedPrinterName: _prefs.getString(_printerNameKey),
        ));

  /// Update Language
  Future<void> setLanguage(String langCode) async {
    await _prefs.setString(_langKey, langCode);
    state = state.copyWith(langCode: langCode);
  }

  /// Toggle Header Text Visibility (Section 1)
  Future<void> toggleHeaderText(bool enabled) async {
    await _prefs.setBool(_headerTextEnabledKey, enabled);
    state = state.copyWith(headerTextEnabled: enabled);
  }

  /// Toggle Header Image Visibility
  Future<void> toggleHeaderImage(bool enabled) async {
    await _prefs.setBool(_headerImageEnabledKey, enabled);
    state = state.copyWith(headerImageEnabled: enabled);
  }

  /// Toggle Footer Message Visibility (Section 3)
  Future<void> toggleFooter(bool enabled) async {
    await _prefs.setBool(_footerEnabledKey, enabled);
    state = state.copyWith(footerEnabled: enabled);
  }

  /// Reset settings to defaults if needed
  Future<void> clearSettings() async {
    await _prefs.remove(_headerTextEnabledKey);
    await _prefs.remove(_headerImageEnabledKey);
    await _prefs.remove(_footerEnabledKey);
    state = SettingsState(langCode: state.langCode);
  }

  /// Get available Bluetooth printer devices
  Future<List<PrinterDevice>> getAvailablePrinterDevices() async {
    try {
      final printerService = PrinterService();
      return await printerService.getAvailableDevices();
    } catch (e) {
      debugPrint('Error getting available printers: $e');
      return [];
    }
  }

  /// Connect to a Bluetooth printer device
  Future<bool> connectToPrinter(PrinterDevice device, String deviceName) async {
    try {
      final printerService = PrinterService();
      final connected = await printerService.connectToDevice(device);
      
      if (connected) {
        // Get address from device
        final address = device.address;
        
        // Save connection info to SharedPreferences
        await _prefs.setString(_printerAddressKey, address);
        await _prefs.setString(_printerNameKey, deviceName);
        
        // Update state
        state = state.copyWith(
          connectedPrinterAddress: address,
          connectedPrinterName: deviceName,
        );
        
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error connecting to printer: $e');
      return false;
    }
  }

  /// Disconnect from the Bluetooth printer
  Future<void> disconnectPrinter() async {
    try {
      final printerService = PrinterService();
      await printerService.disconnect();
      
      // Clear printer info from SharedPreferences
      await _prefs.remove(_printerAddressKey);
      await _prefs.remove(_printerNameKey);
      
      // Update state
      state = state.copyWith(
        connectedPrinterAddress: null,
        connectedPrinterName: null,
      );
    } catch (e) {
      debugPrint('Error disconnecting printer: $e');
    }
  }

  /// Check if a printer is currently connected
  bool isPrinterConnected() {
    return state.connectedPrinterAddress != null && 
           state.connectedPrinterAddress!.isNotEmpty;
  }
}
