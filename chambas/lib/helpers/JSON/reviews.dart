// To parse this JSON data, do
//
//     final empty = emptyFromJson(jsonString);

import 'package:chambas/helpers/JSON/helpers.dart';
import 'dart:convert';

Reviews emptyFromJson(String str) => Reviews.fromJson(json.decode(str));

String emptyToJson(Reviews data) => json.encode(data.toJson());

class Reviews {
    Reviews({
        required this.route,
        required this.reviews,
    });

    String route;
    List<Review> reviews;

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        route: json["route"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "route": route,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    };
}

class Review {
    Review({
        required this.id,
        required this.usuario,
        required this.title,
        required this.points,
        required this.meta,
        required this.view,
        required this.img,
        required this.freelancer,
        required this.createdAt,
        required this.updatedAt,
    });

    Meta meta;
    String id;
    Reference usuario;
    int points;
    String title;
    String view;
    List<dynamic> img;
    String freelancer;
    DateTime createdAt;
    DateTime updatedAt;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        meta: Meta.fromJson(json["meta"]),
        id: json["_id"],
        usuario: Reference.fromJson(json["usuario"]),
        points: json["points"],
        title: json["title"],
        view: json["view"],
        img: List<dynamic>.from(json["img"].map((x) => x)),
        freelancer: json["freelancer"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "_id": id,
        "usuario": usuario.toJson(),
        "points": points,
        "title": title,
        "view": view,
        "img": List<dynamic>.from(img.map((x) => x)),
        "freelancer": freelancer,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

