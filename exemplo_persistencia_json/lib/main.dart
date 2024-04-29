import 'package:exemplo_persistencia_json/View/PaginaInicial.dart';
import 'package:flutter/material.dart';

void main () {
  runApp(MyApp()) ;
}

class 
MyApp extends StatelessWidget {
  const 
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Persistencia Json",
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: HomePage(),
    );
  }
}
