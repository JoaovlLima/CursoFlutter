import 'dart:convert';



import 'package:exemplo_mplay/models/music_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MusicService {
  List<MusicModel> _list = [];
  List<MusicModel> get list => _list;

  final String url = "http://172.27.176.1:3000/musicas";

  //fetchList()
  Future<List<MusicModel>> fetchList() async{
    final Response  response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final List<dynamic> list = json.decode(response.body);
      _list.clear();
      _list.addAll(list.map((e) => MusicModel.fromJson(e)).toList());
      return _list;
    }
    return [];

  }
}