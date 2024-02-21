import 'package:flutter/material.dart';
import './pages/home.dart';
class ResponsiveExampleApp extends StatelessWidget {
  const ResponsiveExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const HomePage()
    );
  }
}