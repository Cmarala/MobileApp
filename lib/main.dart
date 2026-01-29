import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Feature Imports
import 'package:mobileapp/auth/activate_screen.dart';
import 'package:mobileapp/config/env.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/auth/app_launch_service.dart';
import 'package:mobileapp/sync/sync_screen.dart';

// Import your settings providers
import 'package:mobileapp/features/settings/providers/settings_providers.dart';
import 'package:mobileapp/l10n/app_localizations.dart';

void main() async {
  // 1. Core initializations
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Initialize External Services
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // 3. Initialize Local Storage (Crucial for Settings)
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // 4. Eagerly provide the SharedPreferences instance
        // This prevents the 'UnimplementedError' in your SettingsController
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Future<Widget> _getInitialScreen() async {
    final activated = await AppLaunchService.isActivated();
    if (!activated) return const ActivateScreen();
    return const SyncScreen();
  }

  @override
  void initState() {
    super.initState();
    _setupGlobalErrorListener();
  }

  void _setupGlobalErrorListener() {
    Logger.errorStream.listen((errorMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final messenger = ScaffoldMessenger.maybeOf(context);
          messenger?.showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red.shade700,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return FutureBuilder<Widget>(
      future: _getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return MaterialApp(
          title: 'Mobile App',
          debugShowCheckedModeBanner: false,
          
          // Localization delegates
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('te'), // Telugu
          ],
          locale: Locale(settings.langCode),
          
          theme: ThemeData(
            // Use a consistent teal theme to match your reference app screenshots
            primaryColor: const Color(0xFF006064),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006064)),
          ),
          home: snapshot.data,
          builder: (context, child) {
            return ScaffoldMessenger(
              child: child!,
            );
          },
        );
      },
    );
  }
}