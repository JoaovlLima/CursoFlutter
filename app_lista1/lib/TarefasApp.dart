import 'package:app_lista1/TarefaController.dart';
import 'package:app_lista1/TarefaView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTarefasApp extends StatelessWidget{
@override
Widget build(BuildContext context){
  return MaterialApp(
    home: ChangeNotifierProvider(
      create: (context)=> ListaTarefasControler(),
      child: ListaTarefasScreen(),
      ),
  );
}
}