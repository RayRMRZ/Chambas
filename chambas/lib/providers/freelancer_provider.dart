import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chambas/helpers/JSON/helpers.dart';
class FreelancerProvider extends ChangeNotifier{
  final String _baseUrl = 'appchambas.herokuapp.com';
  
  List<Freelance> onDisplayFreelancer = [];

  late ParseFreelance onlyFreelancer; 

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

  Future<bool> getOnDisplayInfo(String uid) async{
  
  final url = Uri.https(_baseUrl,'/api/usuarios/free/$uid');
  final response = await http.get(url, headers: {'content-type': 'application/json'});
  final respfreelance = parseFreelanceFromJson(response.body);
  onlyFreelancer = respfreelance;  

  notifyListeners();
  
  return true;
  }
}