import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sa2_app_autentificacao/db.dart';

import 'Model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showAddContactDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Demo'),
      ),
      body: FutureBuilder<List<ContactModel>>(
        future: dbHelper.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No contacts found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data?[index];
                return ListTile(
                  title: Text(contact!.name),
                  subtitle: Text(contact.email),
                  onTap: () {
                    // Implement onTap functionality
                  },
                );
              },
            );
          }
        },
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            _showAddContactDialog(context);
          },
          child: Text('Login'),
        ),
      ],
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: SingleChildScrollView(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'ID'),
                  keyboardType: TextInputType
                      .number, // Define o tipo de teclado para numérico
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly // Permite apenas a entrada de dígitos
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an ID';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid ID (only digits allowed)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                showCadastroDialog(context);
              },
              child: Text('Cadastrar'),
            ),
            TextButton(
              onPressed: () async {
                bool pessoaRegistrada = await _verificacaoContact();
                if (pessoaRegistrada) {
                  // Permitir login
                  if (_formKey.currentState?.validate() ?? false) {
                    _addContact();
                    Navigator.of(context).pop();
                  }
                } else {
                  // Exibir mensagem de que o email não está registrado
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erro'),
                        content: Text('Email não registrado.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Fechar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Cadastrar'),
                            onPressed: () {
                              showCadastroDialog(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Entrar'),
            ),
          ],
        );
      },
    );
  }

  void showCadastroDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cadastro'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'ID'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _telefoneController,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _addContact();
                Navigator.of(context).pop();
              },
              child: Text('Cadastrar'),
            ),
          ],
        );
      },
    );
  }

  void _addContact() {
    final newContact = ContactModel(
      id: int.parse(_idController.text),
      name: _nameController.text,
      email: _emailController.text,
      telefone: _telefoneController.text,
      senha: _senhaController.text,
    );

    dbHelper.create(newContact);
    setState(() {
      // Atualiza a lista de contatos
    });
  }

  Future<bool> _verificacaoContact() async {
    final email = _emailController.text;
    final usuario = await dbHelper.pesquisar(email);
    bool registrado;

    if (usuario != null) {
      print("Pessoa Registrada");
      print(usuario);
      registrado = true;
    } else {
      print("Pessoa não Registrada");
      registrado = false;
    }
    return registrado;
  }
}
