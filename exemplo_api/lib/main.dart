import 'package:exemplo_api/View/favorite_screen.dart';
import 'package:exemplo_api/View/screen.dart';
import 'package:exemplo_api/View/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:exemplo_api/View/details_weather_screen.dart';

void main(){
  runApp( const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo API',
      theme:  ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      home: HomeScreen(),
      routes: 
      {
        '/home': (context) => HomeScreen(),
        '/favorite': (context) => FavoriteScreen(),
        '/search': (context) => SearchScreen(),
        
        
      },
    );
  }
}