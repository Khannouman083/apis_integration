import 'package:apis/first.dart';
import 'package:apis/fourth.dart';
import 'package:apis/login.dart';
import 'package:apis/second.dart';
import 'package:apis/third.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loginScreen(),
    );
  }
}


