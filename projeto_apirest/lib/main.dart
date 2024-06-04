import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_apirest/screens/home_screen.dart';
import 'package:projeto_apirest/screens/lista_produtos_screen.dart';

void main(){
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sa3",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      
      routes: {
        '/home': (context)=> const HomeScreen(),
        '/list': (context)=> const ListaProdutosScreen(),
      },
    );
  }
}