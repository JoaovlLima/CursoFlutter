import 'package:flutter/material.dart';
import 'package:sa2_app_autentificacao/View.dart';


void main(){

  runApp(Myapp());
}
class Myapp extends StatelessWidget{

 @override
Widget build(BuildContext context) {
  return MaterialApp(
    title: "Projeto SqlLite",
    theme: ThemeData (
     primarySwatch: Colors.blue,
    ),
 home: HomePage(),
  );
}
}