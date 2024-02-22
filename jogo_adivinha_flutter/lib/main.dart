import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

Random random = Random();

class _CalculadoraState extends State<Calculadora> {
  TextEditingController _controllerNumero1 = TextEditingController();

  String _resultado = '';
  String _tentativa = '';
  int cont = 0;
  bool acertou = false;
  int randomNum = random.nextInt(100);

  void _adivinhar(String s) {
    int numero1 = int.tryParse(_controllerNumero1.text) ??
        0; // ?? significa o formato da exibição do numero

    setState(() {
      if (numero1 < randomNum) {
        _resultado = 'está pra cima';
        cont++;
        acertou = false;
      } else if (numero1 > randomNum) {
        _resultado = "está pra baixo";
        cont++;
        acertou = false;
      } else {
        _resultado = "Acertou!!!";
        _tentativa = "Tentativas $cont";
        acertou = true;
      }
    });
  } 
    void _reiniciar() {
      randomNum = random.nextInt(100);
      cont = 0;
      _resultado = '';
      _tentativa = '';
     _controllerNumero1 = TextEditingController();
     acertou = false;
      setState(() {});
    }
  

  @override // Aplicação visual

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerNumero1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 1'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _adivinhar('Somar'), // "onPressed" ao precionar
              child: Text('Tentar'),
            ),
            SizedBox(height: 10.0),
            Visibility(
                visible: acertou,
                child: ElevatedButton(
                  onPressed: () =>
                      _reiniciar(), // "onPressed" ao precionar
                  child: Text('Reiniciar'),
                )),
            SizedBox(height: 16.0),
            Text(_resultado,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            Text(_tentativa,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
