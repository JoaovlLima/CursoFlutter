import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<MyCard> cards = [
    MyCard(
      title: "Card 1",
      description: "Descrição do card 1",
      imageUrl: 'https://imgs.search.brave.com/UXdnqB3Rbb6kyBxJbcFM0EHhSDZ-Rl_IHhVtA-kKims/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAyMy8w/MS8yNy8wNi8xNy9w/aGVhc2FudC03NzQ3/ODMwX18zNDAuanBn',
    ),
    MyCard(
      title: "Card 2",
      description: "Descrição do card 2",
      imageUrl: 'https://imgs.search.brave.com/pp5yPGNZnG6sui5vvGBVHitHdQjet4YusSIGvfGpbuk/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jb250/ZXVkby5pbWd1b2wu/Y29tLmJyL2Mvbm90/aWNpYXMvMGMvMjAy/My8xMS8wNy9pbWFn/ZW0tY2FwdGFkYS1w/ZWxvLXRlbGVzY29w/aW8tZXVjbGlkLWRh/LW5lYnVsb3NhLWNh/YmVjYS1kZS1jYXZh/bG8tdGFtYmVtLWNv/bmhlY2lkYS1jb21v/LWJhcm5hcmQtMzMt/MTY5OTM3MDIxMDU5/OF92Ml85MDB4NTA2/LmpwZw',
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exercicio 10")),
        body: Container(
          child: ListView(
            children: cards,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  MyCard({required this.title, required this.description, required this.imageUrl});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isSelected ? Colors.blueAccent : null,
      child: InkWell(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: ListTile(
          title: Text(widget.title),
          subtitle: Text(widget.description),
          leading: Image.network(
            widget.imageUrl,
            width: 100,
            height: 50,
          ),
        ),
      ),
    );
  }
}
