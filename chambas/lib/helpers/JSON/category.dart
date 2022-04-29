// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';
import 'package:chambas/helpers/JSON/helpers.dart';

ParseCategories categoriesFromJson(String str) => ParseCategories.fromJson(json.decode(str));

String categoriesToJson(ParseCategories data) => json.encode(data.toJson());

class ParseCategories {
    ParseCategories({
        required this.route,
        required this.total,
        required this.categorias,
    });

    String route;
    int total;
    List<ParseCategory> categorias;

    factory ParseCategories.fromJson(Map<String, dynamic> json) => ParseCategories(
        route: json['route'],
        total: json['total'],
        categorias: List<ParseCategory>.from(json['categorias'].map((x) => ParseCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'route': route,
        'total': total,
        'categorias': List<dynamic>.from(categorias.map((x) => x.toJson())),
    };
}

class ParseCategory {
    ParseCategory({
        required this.name,
        required this.usuario,
        required this.img,
        required this.uid,
    });

    String getName(){
      return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
    }

    String name;
    Usuario usuario;
    String img;
    String uid;

    factory ParseCategory.fromJson(Map<String, dynamic> json) => ParseCategory(
        name: json['name'],
        usuario: Usuario.fromJson(json['usuario']),
        img: json['img'],
        uid: json['uid'],
    );

    Map<String, dynamic> toJson() => {
        'name': name,
        'usuario': usuario.toJson(),
        'img': img,
        'uid': uid,
    };
}

class Category {
    Category({
        required this.id,
        required this.name,
        required this.state,
        required this.v,
        required this.img,
    });

    String id;
    String name;
    bool state;
    int v;
    String img;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        state: json["state"],
        v: json["__v"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "state": state,
        "__v": v,
        "img": img,
    };
}

