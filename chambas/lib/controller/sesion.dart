import 'package:chambas/API/httpService.dart';
import 'package:chambas/helpers/validation.dart';

class Session{
  HttpService conexion = HttpService();

  Future<bool> signIn(email,password)async{
    
    int autenticado = await conexion.auth(email: email, password: password);
    
    bool verificado = false;
    switch(autenticado){
      case 0: break;  //No autenticado
      case 1: break; //Autenticado pero no verificado
      case 2: verificado = true; break;
      default: break;
    }
    
    return (verificado==true || autenticado==1)?true:false;
  }

  Future<bool> signUp(name,lastname,address,age,email,password,phone)async{
    Validation validar = Validation();
    bool registro = false;
    
    if(validar.isCorrect(email: email)){
      if(validar.isFormatRight(password: password)){
       registro = await conexion.checkIn(name,lastname,address,age,email,password,phone);
      }
    }
    return registro;
  }
  

}