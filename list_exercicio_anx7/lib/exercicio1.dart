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
color: Colors.red,
width: 100,
height: 100,
// child: Center(
child:
Text("Container 1"),
// )
),
Container(
color: Colors.blue,
width: 150,
height: 150,
),
Container(
color: Colors.green,
width: 200,
height: 200,
)
],)
)
)
);
}
}