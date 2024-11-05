import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '경제 지식 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text("getX 적용"),
    );
  }
}
