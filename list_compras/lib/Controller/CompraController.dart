
// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:list_compras/Model/CompraModel.dart';

class ListaCompraControler extends ChangeNotifier {
  List<Compra> _compras = [];

  List<Compra> get compra => _compras;
  String condicao = '';
  //métodos Crud
  void adicionarTarefa(String descricao, int quantidade){
    if( descricao.trim().isNotEmpty){
      _compras.add(Compra(descricao, quantidade, false));
    notifyListeners();
    }
    
  }
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _compras.length) {
      _compras[indice].comprada = !_compras[indice].comprada;
      notifyListeners();
    } 
    
    
  } 
  
  void excluirTarefa(int indice) {
    if (indice >= 0 && indice < _compras.length) {
      _compras.removeAt(indice);
      notifyListeners();
    }
  }
}