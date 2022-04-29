// ignore: file_names
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService{

  static final AuthService _singleton = AuthService._internal();

  factory AuthService(){
    return _singleton;
  }

  AuthService._internal();

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
}