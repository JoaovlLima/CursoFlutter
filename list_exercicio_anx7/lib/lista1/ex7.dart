import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Menu Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer Menu Example'),
        // Adiciona um ícone de menu para abrir o Drawer
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      // Adiciona o Drawer ao Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Opções do Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Adicione aqui a ação quando a opção 1 for selecionada
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Adicione aqui a ação quando a opção 2 for selecionada
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
            // Adicione mais ListTile conforme necessário para mais opções
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Conteúdo da Página Principal',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
