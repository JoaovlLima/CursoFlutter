

class Weather{
    final String name;
    final String description;
    final String main;
    final double temp;
    final double temp_max;
    final double temp_min;

  Weather({required this.name, required this.description, required this.main, required this.temp, required this.temp_max, required this.temp_min});

factory Weather.fromJson(Map<String,dynamic> json) {
    return Weather(
      name: json['name'],
      description: json['weather'][0]['description'],
      main: json['weather'][0]['main'],
      temp: json['main']['temp'],
      temp_max: json['main']['temp_max'],
      temp_min: json['main']['temp_min'],
    );
  }

}