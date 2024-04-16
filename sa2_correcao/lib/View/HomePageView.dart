import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaHome extends StatefulWidget {
  String email;
  PaginaHome({required this.email, required String nome});

  @override
  State<PaginaHome> createState() => _PaginaHomeState(email: email);
}

class _PaginaHomeState extends State<PaginaHome> {
  late SharedPreferences
      _prefs; // Preferências compartilhadas para armazenar o estado do tema escuro
  bool _concluido = false; // Estado atual do tema escuro
  String email;
  String _descricao = '';

  _PaginaHomeState({required this.email});

  List<String> tarefas = []; // Lista de tarefas
  final TextEditingController _controller =
      TextEditingController(); // Controlador de texto para o campo de entrada de nova tarefa

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências compartilhadas ao iniciar a tela
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences
        .getInstance(); // Obtém as preferências compartilhadas
    setState(() {
      tarefas = _prefs.getStringList('${email}tarefas') ??
          []; // Carrega as tarefas armazenadas ou uma lista vazia se não houver tarefas
    });
  }

  Future<void> saveTarefas() async {
    _prefs = await SharedPreferences
        .getInstance(); // Obtém as preferências compartilhadas
    await _prefs.setStringList('${email}tarefas',
        tarefas); // Salva a lista de tarefas nas preferências compartilhadas
  }
  Future<void> editTarefas(int index) async {
    _prefs = await SharedPreferences.getInstance();

    showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Editar Tarefas'), // Título do diálogo de nova tarefa
                content: TextField(
                  controller:
                      _controller, // Controlador de texto para o campo de entrada
                  decoration: InputDecoration(
                      hintText: 'Digite a tarefa'), // Dica no campo de entrada
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                       tarefas[index] = _controller.text;
                        saveTarefas(); // Salva as tarefas atualizadas
                        _controller.clear(); // Limpa o campo de entrada
                        Navigator.of(context).pop(); // Fecha o diálogo
                      });
                    },
                    child: Text('Adicionar'), // Botão para adicionar a tarefa
                  ),
                ],
              );
            },
          );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'), // Título da barra de aplicativos
      ),
      body: ListView.builder(
        itemCount: tarefas.length, // Número de itens na lista de tarefas
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tarefas[index]),
            trailing: IconButton(
              icon: Icon(Icons.edit), // Ícone de edição
              onPressed: () {
              editTarefas(index);
              },
            ), // Título do item da lista
            onLongPress: () {
              /////////////
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Tem certeza que deseja excluir?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o diálogo
                        },
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            tarefas.removeAt(index); // Remove a tarefa da lista
                            saveTarefas(); // Salva as tarefas atualizadas
                          });
                          Navigator.of(context).pop(); // Fecha o diálogo
                        },
                        child: Text('Sim'),
                      ),
                    ],
                  );
                },
              );
              //////////////
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Nova Tarefa'), // Título do diálogo de nova tarefa
                content: TextField(
                  controller:
                      _controller, // Controlador de texto para o campo de entrada
                  decoration: InputDecoration(
                      hintText: 'Digite a tarefa'), // Dica no campo de entrada
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if(_controller.text.isEmpty){
                          showDialog(
                        context: context,
                        builder: (context){
                         return AlertDialog(actions: [Text('Insira uma tarefa')],);
                        }
                          );
                        }else{
                        tarefas.add(
                            _controller.text); // Adiciona a nova tarefa à lista
                        saveTarefas(); // Salva as tarefas atualizadas
                        _controller.clear(); // Limpa o campo de entrada
                        Navigator.of(context).pop(); // Fecha o diálogo
                        }
                      });
                      
                    },
                    
                    child: Text('Adicionar'), // Botão para adicionar a tarefa
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add), // Ícone do botão de adicionar
      ),
    );
  }
}
