import 'package:exemplo_mplay/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return  MaterialApp(
      title: "Exemplo FireBase",
      home : const HomeScreen(),
      routes: {
        '/home':(context) => const HomeScreen(),
       
      },
    );
  }
}
