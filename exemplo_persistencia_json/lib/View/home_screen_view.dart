import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livraria Senai'),
        
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center
        ,children: [
          ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, '/listar');

          },
          child: Text("Listar Livros"),
          ), SizedBox(height: 16,),
          ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, '/cadastro');
          },
           child: Text("Cadastrar Livros")
          )
        ],
        ),
      ),),
    );
  }
}