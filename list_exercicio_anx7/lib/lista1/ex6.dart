import 'package:flutter/material.dart';
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: ResponsiveLayout(),
);
}
}
class ResponsiveLayout extends StatelessWidget {
@override
Widget build(BuildContext context) {

// Obtém informações de tamanho e orientação da tela
final Size screenSize = MediaQuery.of(context).size;
final Orientation orientation = MediaQuery.of(context).orientation;
return Scaffold(
appBar: AppBar(
title: Text('Layout Responsivo com MediaQuery'),
),
body: Center(
child: Container(
width: screenSize.width * 0.8, // 80% da largura da tela
height: screenSize.height * 0.5, // 50% da altura da tela
color: Colors.blue,
child: Center(
child: Text(
'Tamanho da tela: $screenSize\nOrientação: $orientation',
style: TextStyle(color: Colors.white),
),
),
),
),
);
}
}