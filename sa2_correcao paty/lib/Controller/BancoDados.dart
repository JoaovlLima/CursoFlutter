import 'package:path/path.dart';
import 'package:sa2_correcao/Model/Usuario.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud{
   static const String Nome_db = 'usuarios.db';
  static const String Nome_Tabela = 'usuarios';
  static const String Scrip_Criacao_tabela = "CREATE TABLE usuarios(id SERIAL PRIMARY KEY," +
  "u_nome TEXT, email TEXT UNIQUE, senha TEXT)";

  Future<Database> _getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), Nome_db),
    onCreate: (db, version) {
      return db.execute(Scrip_Criacao_tabela);
    },
    version: 1,
  );
}

Future<void> create(Usuario usuario) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(
          Nome_Tabela, usuario.toMap()); // Insere o contato no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para obter todos os contatos do banco de dados
  Future<Usuario?> getUsuario(String email, String senha) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query(Nome_Tabela,
          where: 'email = ? AND senha = ?',
          whereArgs: [email,senha]
          ); // Consulta todos os contatos na tabela

      if (maps.isNotEmpty){
        return Usuario.fromMap(maps[0]);
      }else{
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para obter todos os contatos do banco de dados
  Future<bool> existsUsuario(String email, String senha) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query(Nome_Tabela,
          where: 'email = ? AND senha = ?',
          whereArgs: [email,senha]
          ); // Consulta todos os contatos na tabela

      if (maps.isNotEmpty){
        return true;
      }else{
        return false;
      }
    } catch (ex) {
      print(ex);
      return false;
    }
  }
  

}