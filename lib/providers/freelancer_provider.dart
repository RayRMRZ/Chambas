import 'dart:async';
import 'package:chambas/helpers/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chambas/helpers/JSON/helpers.dart';
class FreelancerProvider extends ChangeNotifier{
  final String _baseUrl = 'appchambas.herokuapp.com';
  
  List<Freelance> onDisplayFreelancer = [];
  late Reviews onDisplayReviews;

  final StreamController<List<Result>> _suggestionsStreamController = StreamController.broadcast();
  
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),);

  late ParseFreelance onlyFreelancer; 

  FreelancerProvider(){
    getOnDisplayFreePopular();
  }

  Stream<List<Result>> get suggestionStream => _suggestionsStreamController.stream;

  Future<List<Result>> searchFreelance(String query) async{
    final url = Uri.http(_baseUrl,'/api/search/freelance/$query');

    final response = await http.get(url, headers: {'content-type': 'application/json'});

    final searchResponse = searchFromJson(response.body);

    return searchResponse.results;
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
  final url2 = Uri.https(_baseUrl,'/api/reviews/$uid');

  final results = await Future.wait([
    http.get(url, headers: {'content-type': 'application/json'}),
    http.get(url2, headers: {'content-type': 'application/json'})
  ]);
 
  final respfreelance = parseFreelanceFromJson(results[0].body);
  onlyFreelancer = respfreelance;
  final respfreelanceReviews = emptyFromJson(results[1].body);
  onDisplayReviews = respfreelanceReviews;  

  notifyListeners();
  
  return true;
  }
 
  void getSuggestionsByQuery(String query){
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchFreelance(value);
      _suggestionsStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds : 300), (_) { debouncer.value = query; });

    Future.delayed(const Duration(milliseconds : 301)).then((_) => timer.cancel());
  }
}