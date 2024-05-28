import 'package:exemplo_api/Model/weatherModel.dart';
import 'package:exemplo_api/Service/service.dart';

class Weathercontroller {

   List<Weather> _weatherList = [];

   List<Weather> get weatherList => _weatherList;

    final WeatherService _service = WeatherService();

   Future<void> getWeather(String city) async {
    try {
        Weather weather = Weather.fromJson(await _service.getWeather(city));
        _weatherList.add(weather);
    } catch (e) {
      print(e);
      
    }
   
}

 Future<void> getWeatherbyLocation(double lat, double lon) async {
    try {
        Weather weather = Weather.fromJson(await _service.getWeatherbyLocation(lat, lon));
        _weatherList.add(weather);
    } catch (e) {
      print(e);
      
    }
   
}
//find Cidade
Future<bool> findCidade(String city) async{
try {
      return await _service.findCidade(city);
    } catch (e) {
      print(e);
      return false;
    }
  }

}