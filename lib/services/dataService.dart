// ignore: file_names
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService{

final rootURI = 'https://appchambas.herokuapp.com';

final storage = const FlutterSecureStorage();

Future<bool> updateInfo(Map<String, String > media, Map<String, String> info) async{
bool succes = false;
String id = await storage.read(key: 'uid') ?? '';

final url = Uri.parse('$rootURI/api/usuarios/$id');
//final url2 = Uri.parse('$rootURI/api/usuarios/$id');
var frame = jsonEncode(info);

try{
     
      final http.Response resp = await http.put(url, body: frame, headers: {'content-type': 'application/json'});

        if (resp.statusCode == 200) {
        succes = true;
        } else {
        log('Ocurrió un error con la petición! ${resp.statusCode}');
        }

    }catch(error){
      log(error.toString());
    } 
return succes;
}

Future<bool> postReview(Map<String, String> review) async {
bool succes = false;
final url = Uri.parse('$rootURI/api/reviews');
var frame = jsonEncode(review);
String token = await storage.read(key: 'token') ?? '';
try{
     
      final http.Response resp = await http.post(url, body: frame, headers: {'content-type': 'application/json', 'Authoritation': token});

        if (resp.statusCode == 200) {
        succes = true;
        } else {
        log('Ocurrió un error con la petición! ${resp.statusCode}');
        }

    }catch(error){
      log(error.toString());
    } 
return succes;
}
}