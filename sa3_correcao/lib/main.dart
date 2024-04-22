
import 'package:flutter/material.dart';
import 'package:sa3_correcao/View/PaginaLogin.dart';

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
      title: "Sa3",
      debugShowCheckedModeBanner: false,
      home: PaginaLogin(),
    );
  }
}