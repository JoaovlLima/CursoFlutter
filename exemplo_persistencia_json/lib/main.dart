
import 'package:exemplo_persistencia_json/View/cadastrar_livros_view.dart';
import 'package:exemplo_persistencia_json/View/home_screen_view.dart';
import 'package:exemplo_persistencia_json/View/listar_livros_view.dart';
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
    title: 'livraria',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const HomeScreen(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => const HomeScreen(),
      '/cadastro': (context) => LivroCadastroPage(),
      '/listar':(context) => const ListarLivrosScreen()
    },

      
  );
  }
  }
