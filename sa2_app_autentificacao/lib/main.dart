import 'package:flutter/material.dart';

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