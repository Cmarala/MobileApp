import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapp/utils/validators.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/utils/snackbar_helper.dart';
import 'package:mobileapp/utils/permission_helper.dart'; // Standardized Helper
import 'package:mobileapp/widgets/app_button.dart';
import 'package:mobileapp/auth/auth_service.dart';
import 'package:mobileapp/sync/sync_screen.dart';

class ActivateScreen extends StatefulWidget {
  const ActivateScreen({super.key});

  @override
  State<ActivateScreen> createState() => _ActivateScreenState();
}

class _ActivateScreenState extends State<ActivateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passcodeController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passcodeController.dispose();
    super.dispose();
  }

  Future<void> _handleActivate() async {
    if (_loading) return; // Prevent double activation
    
    // 1. UI Validation
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Hardware & Permission Gatekeeper
    // We request all manifest permissions (GPS, SMS, etc.) upfront
    final hasPermissions = await PermissionHelper.requestAllPermissions(context);
    if (!hasPermissions) return;

    setState(() => _loading = true);

    try {
      // 3. API Activation via AuthService (Now returns AppUser model)
      await AuthService.activateApp(
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _passcodeController.text.trim(),
      );

      if (mounted) {
        // 4. Move to Sync (PowerSync takes over here)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SyncScreen()),
        );
      }
    } catch (error, stackTrace) {
      Logger.logError(error, stackTrace, 'Activation process failed');
      if (mounted) {
        SnackBarHelper.show(
          context,
          error.toString().replaceFirst('Exception: ', ''),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activate App'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.verified_user_outlined, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text(
                  'Volunteer Activation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      Validators.validateRequired(value, fieldName: 'Name'),
                  enabled: !_loading,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: '10 digit mobile number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (value.length != 10) {
                      return 'Phone must be exactly 10 digits';
                    }
                    return null;
                  },
                  enabled: !_loading,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _passcodeController,
                  decoration: const InputDecoration(
                    labelText: 'Passcode',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) =>
                      Validators.validateRequired(value, fieldName: 'Passcode'),
                  enabled: !_loading,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleActivate(),
                ),
                const SizedBox(height: 32),
                
                AppButton(
                  label: 'Activate',
                  onPressed: _handleActivate,
                  loading: _loading,
                ),
                const SizedBox(height: 16),
                const Text(
                  'This device will be registered for your campaign area.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}