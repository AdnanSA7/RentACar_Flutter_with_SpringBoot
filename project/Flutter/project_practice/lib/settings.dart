import 'package:flutter/material.dart';
import 'package:project_practice/bottom_navigationbar.dart'; // Import your bottom navbar

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Center(
        child: Text('Settings and Preferences'),
      ),
    );
  }
}
