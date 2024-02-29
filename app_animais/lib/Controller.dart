import 'Model.dart';

class AnimalController{
  //atributos
  List<Animal> _listAnimal = [];
  
  //get Lista
  List get listarAnimal => _listAnimal;

  //adicional_animal

  void adicionarAnimal(String especie, String urlFoto, String urlAudio){
    Animal novoAnimal = Animal(especie,urlFoto,urlAudio);
    _listAnimal.add(novoAnimal);
  }

}