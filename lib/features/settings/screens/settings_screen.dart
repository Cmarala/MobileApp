import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/l10n/app_localizations.dart';
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
          _buildHeaderToggle(context, ref, settings, l10n),
          const Divider(),
          _buildFooterToggle(context, ref, settings, l10n),
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

  Widget _buildHeaderToggle(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
    AppLocalizations? l10n,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.image),
      title: Text(l10n?.showHeader ?? 'Show Header'),
      value: settings.headerEnabled,
      onChanged: (enabled) async {
        try {
          await ref.read(settingsProvider.notifier).toggleHeader(enabled);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(enabled ? 'Header will be added to messages' : 'Header removed from messages'),
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
}
