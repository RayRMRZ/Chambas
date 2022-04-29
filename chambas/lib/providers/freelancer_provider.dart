import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FreelancerProvider extends ChangeNotifier{
  final String _baseUrl = 'appchambas.herokuapp.com';

  List<Freelance> onDisplayFreelancer = [];

  FreelancerProvider(){
    getOnDisplayFreePopular();
  }

  getOnDisplayFreePopular() async{
  final List<String > popularEvidence = [];
  final url = Uri.https(_baseUrl,'/api/usuarios/free');

  final response = await http.get(url, headers: {'content-type': 'application/json'});
  final respfreelance = parseFreeFromJson(response.body);

   for(int i=0; i<respfreelance.usuarios.length; i++){
    popularEvidence.add(respfreelance.usuarios[i].img.toString());
  } 

  onDisplayFreelancer = respfreelance.usuarios;
  
  notifyListeners();
  }
}