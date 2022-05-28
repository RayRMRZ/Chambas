// To parse this JSON data, do
//
//     final parseSession = parseSessionFromJson(jsonString);

import 'user.dart';
import 'dart:convert';

ParseSession parseSessionFromJson(String str) => ParseSession.fromJson(json.decode(str));

String parseSessionToJson(ParseSession data) => json.encode(data.toJson());

class ParseSession {
    ParseSession({
        required this.msg,
        required this.usuario,
        required this.token,
    });

    String msg;
    ParseUser usuario;
    String token;

    factory ParseSession.fromJson(Map<String, dynamic> json) => ParseSession(
        msg: json["msg"],
        usuario: ParseUser.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "usuario": usuario.toJson(),
        "token": token,
    };
}

