import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/shared/constants.dart';

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
    return GetMaterialApp(
        theme: ThemeData(
            primaryColor: Constants().primaryColor,
            scaffoldBackgroundColor: Colors.black),
        home: HomePage());
  }
}
