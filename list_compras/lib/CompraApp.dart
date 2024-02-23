
import 'package:flutter/material.dart';
import 'package:list_compras/Controller/CompraController.dart';
import 'package:list_compras/View/CompraView.dart';
import 'package:provider/provider.dart';

class ListaCompraApp extends StatelessWidget{
@override
Widget build(BuildContext context){
  return MaterialApp(
    home: ChangeNotifierProvider(
      create: (context)=> ListaCompraControler(),
      child: ListaTarefasScreen(),
      ),
  );
}
}