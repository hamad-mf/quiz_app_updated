import 'package:flutter/material.dart';

import 'package:quiz_app_updated/View/Home Screen/home_screen.dart';



void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
    );
  }
}
