import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class Historial {
static final Historial _singleton = Historial._internal();

  factory Historial(){
    return _singleton;
  }

Historial._internal();

List<Map<String, String>> usuarios = [];

final storage = const FlutterSecureStorage();

  add(String id, String img, String name){
    var usuario = {
    'id'  : id,
    'name': name,
    'img' : img };

  usuarios.add(usuario);
  
  }
}

// To parse this JSON data, do
//
//     final historiaItem = historiaItemFromJson(jsonString);

List<HistoriaItem> historiaItemFromJson(String str) => List<HistoriaItem>.from(json.decode(str).map((x) => HistoriaItem.fromJson(x)));

String historiaItemToJson(List<HistoriaItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoriaItem {
    HistoriaItem({
        required this.id,
        required this.name,
        required this.img,
    });

    String id;
    String name;
    String img;

    factory HistoriaItem.fromJson(Map<String, dynamic> json) => HistoriaItem(
        id: json["id"],
        name: json["name"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
    };
}
