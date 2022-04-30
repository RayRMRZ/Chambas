// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);
import 'dart:convert';

import 'package:chambas/helpers/JSON/helpers.dart';

Freelancers parseFreeFromJson(String str) => Freelancers.fromJson(json.decode(str));

String freeToJson(Freelancers data) => json.encode(data.toJson());

class Freelancers {
    Freelancers({
        required this.route,
        required this.total,
        required this.usuarios,
    });

    String route;
    int total;
    List<Freelance> usuarios;

    factory Freelancers.fromJson(Map<String, dynamic> json) => Freelancers(
        route: json["route"],
        total: json["total"],
        usuarios: List<Freelance>.from(json["usuarios"].map((x) => Freelance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "route": route,
        "total": total,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}

Freelance parseFreeOnlyFromJson(String str) => Freelance.fromJson(json.decode(str));

String freeOnlyToJson(Freelance data) => json.encode(data.toJson());

class Freelance {
    Freelance({
        required this.social,
        required this.exp,
        required this.skills,
        required this.categories,
        required this.rank,
        required this.usuario,
        required this.img,
        required this.uid,
    });

    Social social;
    String exp;
    List<String> skills;
    List<Category> categories;
    String rank;
    Reference usuario;
    List<String> img;
    String uid;

    String getfullName(){

      List<String> _name = usuario.name.split(' ');
      List<String> _lastname = usuario.lastname.split(' '); 

      return '${_name[0]} ${_lastname[0]}' ;
    }

    String getSkills(){
      String acum = '';
      for(var elem in skills){
        acum += elem + '\n';
      }
      return acum;
    }
    
    String getAct(){
      String acum = '';
      for(int i = 0; i<3 ; i++){
        acum += skills[i] + '\n';
      }
      return acum;
    }

    factory Freelance.fromJson(Map<String, dynamic> json) => Freelance(
        social: Social.fromJson(json["social"]),
        exp: json["exp"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        rank: json["rank"],
        usuario: Reference.fromJson(json["usuario"]),
        img: List<String>.from(json["img"].map((x) => x)),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "social": social.toJson(),
        "exp": exp,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "rank": rank,
        "usuario": usuario.toJson(),
        "img": List<dynamic>.from(img.map((x) => x)),
        "uid": uid,
    };
}

ParseFreelance parseFreelanceFromJson(String str) => ParseFreelance.fromJson(json.decode(str));

String parseFreelanceToJson(ParseFreelance data) => json.encode(data.toJson());

class ParseFreelance {
    ParseFreelance({
        required this.route,
        required this.freelancer,
    });

    String route;
    Freelance freelancer;

    factory ParseFreelance.fromJson(Map<String, dynamic> json) => ParseFreelance(
        route: json["route"],
        freelancer: Freelance.fromJson(json["freelancer"]),
    );

    Map<String, dynamic> toJson() => {
        "route": route,
        "freelancer": freelancer.toJson(),
    };
}