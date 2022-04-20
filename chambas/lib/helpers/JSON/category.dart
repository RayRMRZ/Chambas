// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
    Categories({
        required this.route,
        required this.total,
        required this.categorias,
    });

    String route;
    int total;
    List<Categoria> categorias;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        route: json['route'],
        total: json['total'],
        categorias: List<Categoria>.from(json['categorias'].map((x) => Categoria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'route': route,
        'total': total,
        'categorias': List<dynamic>.from(categorias.map((x) => x.toJson())),
    };
}

class Categoria {
    Categoria({
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

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
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

class Usuario {
    Usuario({
        required this.id,
        required this.name,
        required this.lastname,
    });

    String id;
    String name;
    String lastname;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['_id'],
        name: json['name'],
        lastname: json['lastname'],
    );

    Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'lastname': lastname,
    };
}
