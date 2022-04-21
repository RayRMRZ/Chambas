import 'package:chambas/services/authService.dart';
import 'package:chambas/models/sesion.dart';
import 'package:chambas/helpers/JSON/helpers.dart';

class User {
  static final User _singleton = User._internal();

  factory User(){
    return _singleton;
  }

  User._internal();

  late String name;
  late String lastname;
  late String age;
  late String address;

  late String img;

  late String email;
  late DateTime registerTime;
  late bool verify;

  Future <Auth> signIn(String email, String password) async{
    AuthService conexion = AuthService();
    String data = await conexion.auth(email: email, password: password);

    if(data != 'auth.fallo'){

      if(data == 'auth.verificar')
      {
        return Auth.verify;
      } else {
    
      var response = parseSessionFromJson(data);
      Session session = Session();
      session.token = response.token;

       name = response.usuario.name;
       lastname = response.usuario.lastname;
       age = response.usuario.age;
       img = response.usuario.img;
       email = response.usuario.email;
       registerTime = response.usuario.createdAt;
       verify = response.usuario.verify;

      return Auth.good; 
      } 
    }else {return Auth.bad;}    
  }
}

enum Auth{
  bad,
  verify,
  good
}