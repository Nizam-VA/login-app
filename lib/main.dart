import 'package:flutter/material.dart';
import 'package:login_demo/Screens/login_page.dart';
import 'package:login_demo/Screens/splash.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: ScreenSplash(),
    );
  }
}
