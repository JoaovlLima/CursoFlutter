import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/city_model.dart';

class CityDbService {
  //atributos de detalha do banco
  static const String DB_NAME = 'db.db'; // Nome do banco de dados
  static const String TABLE_NAME = 'cities'; // Nome da tabela
  static const String CREATE_TABLE_SCRIPT = // Script SQL para criar a tabela
      """CREATE TABLE cities(
          cityname TEXT PRIMARY KEY,
          favoritescities BOOLEAN)""";

  //getDatabase
  Future<Database> _openDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), DB_NAME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }
  //crud
  //insert
  Future<void> insertCity(City city) async {
    try {
      Database db = await _openDatabase();
      db.insert(TABLE_NAME, city.toMap());
      db.close();  
    } catch (e) {
      print(e);
    }   
  }
  //list
  Future<List<Map<String,dynamic>>> listCity() async {
    try {
      Database db = await _openDatabase();
      List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
      db.close();
      return maps;
    } catch (e) {
      print(e);
      return [];
    }
  }
  //delete
  Future<void> deleteCity(String city) async {
    try {
      Database db = await _openDatabase();
      db.delete(TABLE_NAME, where: 'cityname =?', whereArgs: [city]);
      db.close();
    } catch (e) {
      print(e);
    }
  }
  //update favoritesCities
  Future<void> updateCity(City city) async {
    try {
      Database db = await _openDatabase();
      db.update(TABLE_NAME, city.toMap(), where: 'cityname =?', whereArgs: [city.cityName]);
      db.close();
    } catch (e) {
      print(e);
    }
  }


}