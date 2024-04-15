import 'package:flutter/material.dart';
import 'package:sa2_correcao/View/LoginPageView.dart';

void main () {
  runApp(MyApp());
}
class 
MyApp extends StatelessWidget {
  const 
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sa2",
      debugShowCheckedModeBanner: false,
      home: PaginaLogin(),
    );
  }
}