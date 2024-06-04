import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //dois botôes( Litar e cadastrar)
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listar');
              },
              child: const Text('Listar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastrar');
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
         );
  }
}