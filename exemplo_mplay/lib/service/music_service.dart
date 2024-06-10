import 'dart:convert';

import 'package:exemplo_mplay/models/music_model.dart';
import 'package:http/http.dart' as http;

class MusicService {
final Uri url = "http://URL_JSON.com";

List<MusicModel> _listMusic = [];
List<MusicModel> get listMusic => _listMusic;

Future<List<MusicModel>> fetchListMusic() async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    _listMusic = json.decode(response.body).map<MusicModel>((item)=> MusicModel.fromJson(item)).toList();
  } else {
    return Future.error(response.statusCode.toString());
  }
  return _listMusic;
}


//fetch lista de musicas



}