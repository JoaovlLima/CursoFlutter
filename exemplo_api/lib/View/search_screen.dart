import 'package:exemplo_api/Controller/cidadeController.dart';
import 'package:exemplo_api/Controller/weatherController.dart';
import 'package:exemplo_api/Model/cidade_model.dart';
import 'package:exemplo_api/View/details_weather_screen.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _cityController = TextEditingController();
  final Weathercontroller _controller = Weathercontroller();
  final CityController _citydbController = CityController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(hintText: "Search"),
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return "Please enter city name";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                   _cityFind(_cityController.text);
                    }
                  }, 
                  child: const Text("Search")),
                  const SizedBox(height: 12,),
                  FutureBuilder(
                        future: _citydbController.listCities(), 
                        builder: (context,snapshot){
                          if(_citydbController.cities().isNotEmpty){
                            return ListView.builder(
                                itemCount: _citydbController.cities().length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_citydbController.cities()[index].nomeCidade),
                                    onTap: () {
                                      //
                                    },
                                  );
                                });
                          }
                          return const Center(child: Text("Empty Location"));
                        })

                ],
              )),
        ),
      ),
    );
  }
  Future<void> _cityFind(String city) async{
    if(await _controller.findCidade(city)){
      //snackbar 
Cidade cityadd = Cidade(nomeCidade:city,cidadesFavorita:false);
_citydbController.addCity(cityadd);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("City found"),
          duration: Duration(seconds: 1),
        ),
      );
      //navigation to details
      Navigator.push(context,
       MaterialPageRoute(builder: (context) => WeatherDetailsScreenState(nomeCidade:city)));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("City not found"),
          duration: Duration(seconds: 2),
        ),
      );
      _cityController.clear();
    }

  }
}
