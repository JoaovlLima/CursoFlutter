import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sa3_correcao/Controller/BancoDados.dart';
import 'package:sa3_correcao/Model/Usuario.dart';

class PaginaHome extends StatefulWidget {
  String email;
  PaginaHome({required this.email, required String nome});

  @override
  State<PaginaHome> createState() => _PaginaHomeState(email: email);
}

class _PaginaHomeState extends State<PaginaHome> {
  late SharedPreferences _prefs;
  bool _concluido = false;
  String email;
  String _descricao = '';

  _PaginaHomeState({required this.email});

  List<String> tarefas = [];
  final TextEditingController _controller = TextEditingController();

  List<Usuario> usuarios = [];
  BancoDadosCrud bancoDados = BancoDadosCrud();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _fetchUsers();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      tarefas = _prefs.getStringList('${email}tarefas') ?? [];
    });
  }

    Future<void> _fetchUsers() async {
      try {
        List<Usuario> fetchedUsers = await bancoDados.readAll();
        setState(() {
          usuarios = fetchedUsers;
        });
      } catch (e) {
        print('Erro ao buscar usuários: $e');
      }
    }

  Future<void> saveTarefas() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setStringList('${email}tarefas', tarefas);
  }

  Future<void> editTarefas(int index) async {
    _prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Tarefas'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Digite a tarefa'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  tarefas[index] = _controller.text;
                  saveTarefas();
                  _controller.clear();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Adicionar'),
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
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tarefas[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      editTarefas(index);
                    },
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Tem certeza que deseja excluir?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  tarefas.removeAt(index);
                                  saveTarefas();
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Sim'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          Text('Lista de Usuários'),
          Expanded(
            child: ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(usuarios[index].nome),
                  subtitle: Text(usuarios[index].email),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Nova Tarefa'),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Digite a tarefa'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [Text('Insira uma tarefa')],
                              );
                            },
                          );
                        } else {
                          tarefas.add(_controller.text);
                          saveTarefas();
                          _controller.clear();
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
