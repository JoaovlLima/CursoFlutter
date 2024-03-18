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
        leading: Image.network('https://imgs.search.brave.com/UXdnqB3Rbb6kyBxJbcFM0EHhSDZ-Rl_IHhVtA-kKims/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAyMy8w/MS8yNy8wNi8xNy9w/aGVhc2FudC03NzQ3/ODMwX18zNDAuanBn',
        width: 100,
        height: 50,),
      ),
    ),
    Card(
      child: ListTile(
        title: Text("Card 2"),
        subtitle: Text('Descrição do card 2'),
        
        leading: Image.network('https://imgs.search.brave.com/pp5yPGNZnG6sui5vvGBVHitHdQjet4YusSIGvfGpbuk/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jb250/ZXVkby5pbWd1b2wu/Y29tLmJyL2Mvbm90/aWNpYXMvMGMvMjAy/My8xMS8wNy9pbWFn/ZW0tY2FwdGFkYS1w/ZWxvLXRlbGVzY29w/aW8tZXVjbGlkLWRh/LW5lYnVsb3NhLWNh/YmVjYS1kZS1jYXZh/bG8tdGFtYmVtLWNv/bmhlY2lkYS1jb21v/LWJhcm5hcmQtMzMt/MTY5OTM3MDIxMDU5/OF92Ml85MDB4NTA2/LmpwZw',
        width: 100,
        height: 50,),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exercicio 3")),
        body:Container(
           child: 
              ListView(
                children: cards,
              ),
               
           
          
        ),
      ),
    );
  }
}