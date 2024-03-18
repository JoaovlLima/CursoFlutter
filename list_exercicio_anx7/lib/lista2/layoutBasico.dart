import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: (Scaffold(
            appBar: AppBar(
              title: Text("Layout basico"),
            ),
            body: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("linha1"),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 24.0,
                      )
                    ],
                  )
                ],
              ),
            ))));
  }
}
