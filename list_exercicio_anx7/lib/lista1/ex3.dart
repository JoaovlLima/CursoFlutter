import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item $index');
  final List<Widget> cards = [
    Card(
      child: ListTile(
        title: Text("Card 1"),
        subtitle: Text('Descrição do card 1'),
        leading: Icon(Icons.android),
      ),
    ),
    Card(
      child: ListTile(
        title: Text("Card 2"),
        subtitle: Text('Descrição do card 2'),
        leading: Icon(Icons.android),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exercicio 3")),
        body: ListView(
          children: [
          //  ListView(
          //       children: itens,
          //     ),
            for (String item in items)
              Card(
                child: ListTile(
                  title: Text(item),
                  subtitle: Text('Informações fictícias'),
                  leading: Icon(Icons.info),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
