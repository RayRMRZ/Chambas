
import 'package:chambas/helpers/JSON/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier{
  final String _baseUrl = 'appchambas.herokuapp.com';

  List<Categoria> onDisplayCategory = [];

  CategoryProvider(){
    getOnDisplayCategory();
  }

  getOnDisplayCategory() async{
  final List<String > category = [];
  final url = Uri.https(_baseUrl,'/api/categorias', {'limit': '20'});

  final response = await http.get(url, headers: {'content-type': 'application/json'});
  final respCat = categoriesFromJson(response.body);

   for(int i=0; i<respCat.categorias.length; i++){
    category.add(respCat.categorias[i].img.toString());
  } 

  onDisplayCategory = respCat.categorias;

  notifyListeners();
  }
}