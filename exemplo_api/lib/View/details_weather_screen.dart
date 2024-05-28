import 'package:exemplo_api/Controller/weatherController.dart';
import 'package:flutter/material.dart';

class WeatherDetailsScreenState extends StatefulWidget {
  final String nomeCidade;
  const WeatherDetailsScreenState({super.key,required this.nomeCidade});

  @override
  State<WeatherDetailsScreenState> createState() => _WeatherDetailsScreenStateState();
}

class _WeatherDetailsScreenStateState extends State<WeatherDetailsScreenState> {
  final Weathercontroller _controller = Weathercontroller();
  @override
  void initState() {
    _controller.getWeather(widget.nomeCidade);
     super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeCidade),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Weather Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height:20),
            FutureBuilder(
            future: _controller.getWeather(widget.nomeCidade), 
            builder: (context, snapshot){
              if(_controller.weatherList.isEmpty){
                return const Center(child: CircularProgressIndicator());
              }else{
                return Column(
                children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_controller.weatherList.last.name),
                        //icon favorite
                        IconButton(
                          icon: const Icon(Icons.favorite_border_outlined),
                          onPressed: (){
                            // adicionar aos favoritos
                          },
                        ),
                      ],
                    ),
                    Text(_controller.weatherList.last.description),
                    Text((_controller.weatherList.last.temp-273).toStringAsFixed(2)),
                    
                  ],
                );
              }

            })
          ],
        ),
      ),
    );
  }
}