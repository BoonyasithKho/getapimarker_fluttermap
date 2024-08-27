import 'package:flutter/material.dart';
import 'package:getapimarker_fluttermap/screens/Landing/landing_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingScreen(),
    );
  }
}
