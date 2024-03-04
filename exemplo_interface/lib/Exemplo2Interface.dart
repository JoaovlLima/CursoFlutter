import 'package:flutter/material.dart';



void main(){

runApp(MyApp());

}

class MyApp extends StatelessWidget {
// Método build, obrigatório em StatelessWidget, retorna a árvore de
// widgets da aplicação
@override
Widget build(BuildContext context) {
// Retorna um MaterialApp, que é o widget raiz da aplicação Flutter
return MaterialApp(
// Configura a tela inicial como um Scaffold
home: Scaffold(
// Barra superior da tela (AppBar)
appBar: AppBar(
// Título da barra superior
title: Text("Tarefa"),
),
// Corpo da tela, composto por um Column (coluna vertical) de
// widgets
body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Column(
       children: [
        Row(
          children: [
            Icon(Icons.person, color: Colors.blue, size: 30.0),
            Text("Nome: "),
            Text("João"),
            
            
          ],
        ),
        Row(
          children: [
            Text("Idade: "),
            Text("20")
          ],
        ),
        Row(
          children: [
            Text("Endereço: "),
            Text("Limeira")
          ],
        ),
        Row(
          children: [
            Text("Telefone: "),
            Text("40028922")
          ],
        ),
        Row(
          children: [
            Text("Email: "),
            Text("joao@gmail")
          ],
        )
       ],
    ),
     
  ],
)
),
);
}
}