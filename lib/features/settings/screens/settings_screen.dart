import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/l10n/app_localizations.dart';
import 'package:mobileapp/utils/printer_service.dart';
import '../providers/settings_providers.dart';
import '../models/settings_state.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.settings ?? 'Settings'),
      ),
      body: ListView(
        children: [
          _buildLanguageSection(context, ref, settings, l10n),
          const Divider(),
          _buildHeaderTextToggle(context, ref, settings, l10n),
          const Divider(),
          _buildHeaderImageToggle(context, ref, settings, l10n),
          const Divider(),
          _buildFooterToggle(context, ref, settings, l10n),
          const Divider(),
          _buildPrinterSection(context, ref, settings, l10n),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
    AppLocalizations? l10n,
  ) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(l10n?.language ?? 'Language'),
      subtitle: Text(settings.langCode == 'en' ? 'English' : 'తెలుగు'),
      trailing: DropdownButton<String>(
        value: settings.langCode,
        items: const [
          DropdownMenuItem(value: 'en', child: Text('English')),
          DropdownMenuItem(value: 'te', child: Text('తెలుగు')),
        ],
        onChanged: (newLang) async {
          if (newLang != null) {
            try {
              await ref.read(settingsProvider.notifier).setLanguage(newLang);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n?.languageChanged ?? 'Language changed'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${l10n?.error ?? 'Error'}: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }

  Widget _buildHeaderTextToggle(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
    AppLocalizations? l10n,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.text_fields),
      title: Text(l10n?.showHeaderText ?? 'Add Header Text'),
      value: settings.headerTextEnabled,
      onChanged: (enabled) async {
        try {
          await ref.read(settingsProvider.notifier).toggleHeaderText(enabled);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(enabled ? 'Header text will be added to messages' : 'Header text removed from messages'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${l10n?.error ?? 'Error'}: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildHeaderImageToggle(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
    AppLocalizations? l10n,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.image),
      title: Text(l10n?.showHeader ?? 'Add Header Image'),
      value: settings.headerImageEnabled,
      onChanged: (enabled) async {
        try {
          await ref.read(settingsProvider.notifier).toggleHeaderImage(enabled);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(enabled ? 'Header image will be added to messages' : 'Header image removed from messages'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${l10n?.error ?? 'Error'}: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildFooterToggle(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
    AppLocalizations? l10n,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.short_text),
      title: Text(l10n?.showFooter ?? 'Show Footer'),
      value: settings.footerEnabled,
      onChanged: (enabled) async {
        try {
          await ref.read(settingsProvider.notifier).toggleFooter(enabled);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(enabled ? 'Footer will be added to messages' : 'Footer removed from messages'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${l10n?.error ?? 'Error'}: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildPrinterSection(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
    AppLocalizations? l10n,
  ) {
    final isPrinterConnected = settings.connectedPrinterAddress != null && 
                               settings.connectedPrinterAddress!.isNotEmpty;

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.print),
          title: const Text('Thermal Printer'),
          subtitle: isPrinterConnected
              ? Text('Connected: ${settings.connectedPrinterName}')
              : const Text('Not Connected'),
        ),
        if (isPrinterConnected)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                try {
                  await ref.read(settingsProvider.notifier).disconnectPrinter();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Printer disconnected'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${l10n?.error ?? 'Error'}: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Disconnect'),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () => _showPrinterSelectionDialog(context, ref, l10n),
              child: const Text('Connect Printer'),
            ),
          ),
      ],
    );
  }

  Future<void> _showPrinterSelectionDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
  ) async {
    try {
      // Get available printers
      final devices = await ref.read(settingsProvider.notifier).getAvailablePrinterDevices();

      if (!context.mounted) return;

      if (devices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Bluetooth printers found'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }

      // Show printer selection dialog
      final selectedDevice = await showDialog<PrinterDevice>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Select Printer'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return ListTile(
                    title: Text(device.name),
                    subtitle: Text(device.address),
                    onTap: () {
                      Navigator.of(dialogContext).pop(device);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n?.cancel ?? 'Cancel'),
              ),
            ],
          );
        },
      );

      if (selectedDevice == null) return;

      // Show connecting message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connecting to printer...'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Connect to selected printer
      final connected = await ref.read(settingsProvider.notifier).connectToPrinter(
        selectedDevice,
        selectedDevice.name,
      );

      if (!context.mounted) return;

      if (connected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Printer connected successfully'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to connect to printer'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n?.error ?? 'Error'}: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
