import 'package:exemplo_api/Model/cidade_model.dart';
import 'package:exemplo_api/Service/cidade_database_service.dart';

class CityController{
  List<Cidade> _cities = [];
final CityDbService _service = CityDbService();
  List<Cidade> cities() => _cities;

Future<List<Cidade>> listCities() async {
  List<Map<String,dynamic>>maps = await _service.listCity();
  // for (Map<String,dynamic> map in maps){
  //   cities.add(Cidade.fromMap(map));
  // }
  _cities = maps.map<Cidade>((e) => Cidade.fromMap(e)).toList();
  return _cities;
}
Future<void> addCity (Cidade city) async{
  await _service.insertCity(city);
}
Future<void> updateCity (Cidade city) async{
await _service.updateCity(city);
}
Future<void> deleteCity (String city) async{
  await _service.deleteCity(city);
}
}