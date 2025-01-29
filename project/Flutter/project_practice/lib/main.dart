import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_practice/bottom_navigationbar.dart';
import 'package:project_practice/home.dart';
import 'package:project_practice/login.dart';
import 'package:project_practice/registration.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentACar',
      theme: ThemeData(
        primaryColor: Color(0xFF2C3E50),
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Initial route of the app
      routes: {
        '/login': (context) => const LoginPage(), // Define the login page
        '/home': (context) => const BottomNavbar(), // Define the home page
        '/register': (context) => const RegistrationPage(), // Define the sign up page
      },
      // home: const LoginPage(),
    );
  }
}
