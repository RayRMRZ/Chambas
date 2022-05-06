// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);
import 'dart:convert';
import 'package:chambas/helpers/JSON/helpers.dart';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
    Search({
        required this.results,
    });

    List<Result> results;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.id, 
        required this.exp, 
        required this.skills,
        required this.social,
        required this.categories,
        required this.rank,
        required this.usuario,
        required this.img,
        required this.ref, 
    });

    String id;
    String exp;
    List<String> skills;
    Social social;
    List<String> categories;
    String rank;
    String usuario;
    List<String> img;
    Reference ref;

  String getSkills(){
      String acum = '';
      for(var elem in skills){
        acum += elem + '\n';
      }
      return acum;
  }
    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        exp: json["exp"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        social: Social.fromJson(json["social"]),
        categories: List<String>.from(json["categories"].map((x) => x)),
        rank: json["rank"],
        usuario: json["usuario"],
        img: List<String>.from(json["img"].map((x) => x)),
        ref: Reference.fromJson(json["ref"]),
    );

    Map<String, dynamic> toJson() => {
        "_id" : id,
        "exp": exp,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "social": social.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "rank": rank,
        "usuario": usuario,
        "img": List<dynamic>.from(img.map((x) => x)),
        "ref": ref.toJson(),
    };
}



