import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 1'),
              onTap: () {
            
                Navigator.pop(context); // Fechar o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 2'),
              onTap: () {
                
                 Navigator.pop(context); // Fechar o drawer
              },
            ),
             ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 3'),
              onTap: () {
                
                 Navigator.pop(context); // Fechar o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Aba 4'),
              onTap: () {
                
                 Navigator.pop(context); // Fechar o drawer
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}

