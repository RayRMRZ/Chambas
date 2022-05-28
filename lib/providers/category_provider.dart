
import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier{
  final String _baseUrl = 'appchambas.herokuapp.com';

  List<ParseCategory> onDisplayCategory = [];
  List<Freelance> onDisplayFreelancerHome = [];
  List<Freelance> onDisplayFreeAgricultura = [];
  List<Freelance> onDisplayFreelancerPC = [];

  CategoryProvider(){
    getOnDisplayCategory();
    getFreelancersByCategory();
  }

  getOnDisplayCategory() async{
  final List<String > category = [];
  final url = Uri.https(_baseUrl,'/api/categorias', {'limit': '15'});

  final response = await http.get(url, headers: {'content-type': 'application/json'});
  final respCat = categoriesFromJson(response.body);

   for(int i=0; i<respCat.categorias.length; i++){
    category.add(respCat.categorias[i].img.toString());
  } 

  onDisplayCategory = respCat.categorias;

  notifyListeners();
  }
  getFreelancersByCategory() async{
  final url = Uri.https(_baseUrl,'/api/usuarios/free/category/62582dacbfd25a4780637a82', );
  final url2 = Uri.https(_baseUrl,'/api/usuarios/free/category/627f20f5b238a24871bf6999', );
  final url3 = Uri.https(_baseUrl,'/api/usuarios/free/category/627f1deeb238a24871bf6980',);
  
final results = await Future.wait([
    http.get(url, headers: {'content-type': 'application/json'}),
    http.get(url2, headers: {'content-type': 'application/json'}),
    http.get(url3, headers: {'content-type': 'application/json'}),

  ]);

  final home = parseFreeFromJson(results[0].body);
  onDisplayFreelancerHome = home.usuarios;
  final computer = parseFreeFromJson(results[1].body);
  onDisplayFreelancerPC = computer.usuarios;
  final negocio = parseFreeFromJson(results[2].body);
  onDisplayFreeAgricultura = negocio.usuarios;
  
  notifyListeners();
  }
}