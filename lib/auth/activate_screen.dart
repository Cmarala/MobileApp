import 'package:flutter/material.dart';
import 'package:mobileapp/utils/validators.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/utils/snackbar_helper.dart';
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _loading = true);

    try {
      await AuthService.activateApp(
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _passcodeController.text.trim(),
      );

      if (mounted) {
        // Prevent duplicate navigation by checking if still mounted and not loading
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SyncScreen()),
        );
      }
    } catch (error, stackTrace) {
      Logger.logError(error, stackTrace);
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
      appBar: AppBar(title: const Text('Activate App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    Validators.validateRequired(value, fieldName: 'Name'),
                enabled: !_loading,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                enabled: !_loading,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passcodeController,
                decoration: const InputDecoration(labelText: 'Passcode'),
                obscureText: true,
                validator: (value) =>
                    Validators.validateRequired(value, fieldName: 'Passcode'),
                enabled: !_loading,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Activate App',
                onPressed: _handleActivate,
                loading: _loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
