import 'package:flutter/material.dart';
import 'dart:math';


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

class _CalculadoraState extends State<Calculadora> {
  TextEditingController _controllerNumero1 = TextEditingController();
 
  String _resultado = '';
  String _tentativa = '';

  void _calcular(String operacao) {
    int numero1 = int.tryParse(_controllerNumero1.text) ??
        0; // ?? significa o formato da exibição do numero
    
    Random random = Random();
    int? resultado;
    int randomNum = random.nextInt(100);
    int cont = 0;
    

    setState(() {
     do {
      if (numero1 < randomNum) {
        _resultado = 'está pra cima';
        cont = cont + 1;
      } else if (numero1 > randomNum) {
        _resultado = "está pra baixo";
        cont = cont + 1;
      } else {
        _resultado = "Acertou!!!";
      }
    } while (_resultado != "Acertou!!!"); 

       _tentativa = "Tentativas $cont";
    });
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
              onPressed: () => _calcular('Somar'), // "onPressed" ao precionar
              child: Text('Tentar'),
            ),
           
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
