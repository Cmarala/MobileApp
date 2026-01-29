import 'package:flutter/material.dart';
import 'package:mobileapp/auth/activate_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ActivateScreen(),
    );
  }
}
