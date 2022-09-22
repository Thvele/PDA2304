import 'package:flutter/material.dart';
import 'package:flutter_pr1_v1/layoutNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: const Color.fromRGBO(3, 158, 162, 1)),
      home: const LayoutNav(),
    );
  }
}
