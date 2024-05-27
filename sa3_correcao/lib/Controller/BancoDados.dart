import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sa3_correcao/Model/Usuario.dart';

class BancoDadosCrud {
  static const String apiUrl = 'http://10.109.207.237:3000/usuarios';

  Future<void> create(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toMap()),
      );

      if (response.statusCode == 201) {
        print('Usuário criado com sucesso: ${response.body}');
      } else {
        print('Erro ao criar usuário: ${response.statusCode}');
        print('Resposta: ${response.body}');
        throw Exception('Erro ao criar usuário: ${response.body}');
      }
    } catch (e) {
      print('Erro ao criar usuário: $e');
    }
  }

  Future<List<Usuario>> readAll() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Usuario.fromMap(json)).toList();
      } else {
        throw Exception('Erro ao buscar usuários: ${response.body}');
      }
    } catch (e) {
      print('Erro ao ler os usuários: $e');
      return [];
    }
  }

  Future<Usuario?> getUsuario(String nome, String senha) async {
    try {
      List<Usuario> usuarios = await readAll();
      for (var usuario in usuarios) {
        if (usuario.nome == nome && usuario.senha == senha) {
          return usuario;
        }
      }
      return null;
    } catch (e) {
      print('Erro ao buscar usuário: $e');
      return null;
    }
  }

  Future<bool> readByName(String nome) async {
    try {
      List<Usuario> usuarios = await readAll();
      return usuarios.any((u) => u.nome == nome);
    } catch (e) {
      print('Erro ao buscar usuário por nome: $e');
      return false;
    }
  }
}
