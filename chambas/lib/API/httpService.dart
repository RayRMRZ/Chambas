// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService{

  Future <int> auth({required String email, required String password}) async {

    Completer completer = Completer<String>();
    int succes = 0;
    final url = Uri.parse('https://appchambas.herokuapp.com/api/auth/login');
    var data = jsonEncode({'email' : email , 'password' : password});

   try{

      final http.Response resp = await http.post(url, body: data , headers: {'content-type': 'application/json'});

        if (resp.statusCode == 200) {
          completer.complete('Se ha realizado la petición http\n');
          succes = 2;
        } else if(resp.statusCode == 400 ){
          var messages = json.decode(resp.body);
          if(messages['msg'] == 'Usuario no verificado'){
            succes = 1;
          }
        }else{
        completer.completeError('Ocurrió un error con la petición! ${resp.statusCode}');
        }

    }catch(error){
      completer.completeError('Sin conexión a internet');
    }
    return succes;
  }

  Future <bool> checkIn(String name, String lastname, String address, String age, String email, String password, String phone) async{
    final url = Uri.parse('https://appchambas.herokuapp.com/api/usuarios');
    var frame = jsonEncode({
	  "name"    :     name,
	  "lastname": lastname,
	  "address" : address,
	  "age"     : age,
	  "email"   : email,
	  "password": password,
	  "phone"   : phone,
	  "role"    : "USER_ROLE"});

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