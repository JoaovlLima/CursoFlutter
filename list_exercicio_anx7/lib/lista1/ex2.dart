

import 'package:flutter/material.dart';
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget{
@override
Widget build(BuildContext context) {
return MaterialApp(
home: Scaffold(
appBar:AppBar(title: Text("Exercicio2")) ,
body: Container(
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Column(
children: [
Text('Texto da Primeira Coluna'),
//Icone
],
),
Column(
children: [
Text('Texto da Segunda Coluna')
],
),
Column(
children: [
Text('Texto da Terceira Coluna')
],
),
],),
)),
);
}
}