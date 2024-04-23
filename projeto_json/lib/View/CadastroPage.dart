import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulário de Cadastro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descrição do Produto'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Preço do Produto'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Categoria do Produto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para salvar os dados do formulário
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}