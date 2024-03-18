// Layout Básico com Container:
// Crie um aplicativo Flutter que utilize o widget Container para criar
// um layout básico.
// Adicione pelo menos três widgets filhos dentro do Container com
// diferentes estilos e
// cores.
import 'package:flutter/material.dart';
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: (Scaffold(appBar: AppBar(
title: Text("3 Container"),)
,body: Column(
children: [
Container(
color: Color.fromARGB(255, 25, 75, 166),
width: 200,
height: 100,
// child: Center(
child:
Text("Container 1"),
// )
),
Container(
color: Color.fromARGB(255, 120, 236, 180),
width: 300,
height: 150,
),
Container(
color: Colors.green,
width: 400,
height: 200,
)
],)
)
)
);
}
}