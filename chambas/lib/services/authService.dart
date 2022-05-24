
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService{

  static final AuthService _singleton = AuthService._internal();

  factory AuthService(){
    return _singleton;
  }

  AuthService._internal();

  final storage = const FlutterSecureStorage();
 final rootURI = 'https://appchambas.herokuapp.com';

  Future <String> auth({required String email, required String password}) async {

    Completer completer = Completer<String>();

    final url = Uri.parse('$rootURI/api/auth/login');
    var body = jsonEncode({'email' : email , 'password' : password});
    String data = 'auth.fallo';

   try{

      final http.Response resp = await http.post(url, body: body , 
                                      headers: {'content-type': 'application/json'});

        if (resp.statusCode == 200) {
          completer.complete('Se ha realizado la petición http\n');
          data = resp.body;

        } else if(resp.statusCode == 400 ){
          var msg = jsonDecode(resp.body);
          if(msg['msg'] == 'Usuario no verificado'){data = 'auth.verificar';} 

        }else{
        completer.completeError('Ocurrió un error con la petición! ${resp.statusCode}');
        }

    }catch(error){
      completer.completeError('Sin conexión a internet');
    }
    return data;
  }

  Future <bool> checkIn({required String name, required String lastname,required String address,required String age,required String email,required String password ,required String phone }) async{
    final url = Uri.parse('$rootURI/api/usuarios');
    var frame = jsonEncode({
	  'name'    :     name,
	  'lastname': lastname,
	  'address' : address,
	  'age'     : age,
	  'email'   : email,
	  'password': password,
	  'phone'   : phone, 
	  'role'    : "USER_ROLE"});

    Completer completer = Completer<String>();
    bool succes = false;
    
   try{
     
      final http.Response resp = await http.post(url, body: frame , headers: {'content-type': 'application/json'});

        if (resp.statusCode == 200) {
        succes = true;
        } else {
        completer.completeError('Ocurrió un error con la petición! ${resp.statusCode}');
        }

    }catch(error){
      completer.completeError('Sin conexión a internet');
    }
    return succes;
  }

  Future <bool> toFreelance(
      { required String desc, 
        required String exp,
        required List<String> skills,
        required Map < String , Map<String,String>> media,
        required List<String> categories,
        required String usuario } ) async{

    final url = Uri.parse('$rootURI/api/usuarios/free');
    var frame = jsonEncode({
	  'desc'    :     desc,
	  'exp'     :     exp,
	  'skills'  :   skills,
	  'social'  :   media,
	  'categories': categories,
	  'usuario':    usuario,  }); 

    Completer completer = Completer<String>();  
    bool succes = false;
    String token = await storage.read(key: 'token') ?? '';
    
    try{
     
      final http.Response resp = await http.post(url, body: frame , headers: {'content-type': 'application/json', 'Authoritation': token});

        if (resp.statusCode == 200) {
        succes = true;
        } else {
        completer.completeError('Ocurrió un error con la petición! ${resp.statusCode}');
        }

    }catch(error){
      completer.completeError('Sin conexión a internet');
    } 
    return succes; 
  }

  Future<bool> updateImage(String uid,File? pictureFile) async{
    final url = Uri.parse('$rootURI/api/file/usuario/$uid');
    final imageRequest = http.MultipartRequest('PUT', url );
    String token = await storage.read(key: 'token') ?? '';
    imageRequest.headers['Authoritation'] =  token;
    final file = await http.MultipartFile.fromPath('archivo', pictureFile!.path, 
    contentType: MediaType('multipart', 'form-data'),);

    imageRequest.files.add(file);

    // ignore: unused_local_variable
    final streamResponse = await imageRequest.send();
    return true;
  }
}