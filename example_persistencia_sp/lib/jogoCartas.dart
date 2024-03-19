import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyMemoryGame());
}

class MyMemoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoryGamePage(),
    );
  }
}

class MemoryGamePage extends StatefulWidget {
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  late List<bool> _flipped;
  late List<int> _items;
  late int _previousIndex;
  late int _currentIndex;
  bool _isBusy = false;
  int _moves = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _flipped = List.generate(36, (_) => false);
    _items = List.generate(18, (index) => index + 1)..addAll(List.generate(18, (index) => index + 1));
    _items.shuffle();
    _previousIndex = -1;
    _currentIndex = -1;
    _isBusy = false;
    _moves = 0;
  }

  void _onTileClicked(int index) {
    if (!_isBusy && !_flipped[index]) {
      setState(() {
        _flipped[index] = true;
        if (_previousIndex == -1) {
          _previousIndex = index;
        } else {
          _currentIndex = index;
          _isBusy = true;
          _moves++;
          if (_items[_previousIndex] != _items[_currentIndex]) {
            Timer(Duration(milliseconds: 500), () {
              setState(() {
                _flipped[_previousIndex] = false;
                _flipped[_currentIndex] = false;
                _previousIndex = -1;
                _currentIndex = -1;
                _isBusy = false;
              });
            });
          } else {
            _previousIndex = -1;
            _currentIndex = -1;
            _isBusy = false;
            if (_flipped.every((element) => element)) {
              _showGameCompleteDialog();
            }
          }
        }
      });
    }
  }

  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Parabéns!'),
        content: Text('Você completou o jogo em $_moves movimentos.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeGame();
            },
            child: Text('Jogar Novamente'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 18.0,
          crossAxisSpacing: 18.0,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onTileClicked(index);
            },
            child: Card(
              color: _flipped[index] ? Colors.blue : Colors.grey,
              child: Center(
                child: _flipped[index]
                    ? Text(
                        '${_items[index]}',
                        style: TextStyle(fontSize: 24.0),
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
