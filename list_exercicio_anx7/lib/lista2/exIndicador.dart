import 'package:flutter/material.dart';

class ProgressIndicatorExample extends StatefulWidget {
  @override
  _ProgressIndicatorExampleState createState() => _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample> {
  double _progressValue = 0.0;
  bool _isLoading = false;

  void _startLoading() {
    setState(() {
      _isLoading = true;
      _progressValue = 0.0;
    });

    // Simula uma tarefa assíncrona
    Future.delayed(Duration(milliseconds: 100), () {
      _updateProgress();
    });
  }

  void _updateProgress() {
    setState(() {
      _progressValue += 0.1;
    });

    if (_progressValue < 1.0) {
      // Atualiza o progresso até alcançar 100%
      Future.delayed(Duration(milliseconds: 500), () {
        _updateProgress();
      });
    } else {
      // Quando o progresso atinge 100%, redefine o estado de isLoading
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de Indicador de progresso'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isLoading ? null : _startLoading,
              child: Text('Start Loading'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator(value: _progressValue)
                : Text('Pressione o botão para iniciar o carregamento'),
          ],
        ),
      ),
    );
  }
}
