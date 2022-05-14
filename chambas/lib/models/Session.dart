
import 'package:chambas/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Session extends ChangeNotifier{

  String _token = '';
  final storage = const FlutterSecureStorage();
  
  Session(){
    saveTokenStorage();
  }
  set token(tkn){ _token = tkn;}

  saveTokenStorage() async{
    await storage.write(key: 'token', value: _token);
  }
  Future <String> readToken() async{
    return await storage.read(key: 'token') ?? '';
  }

  Future logout()async{
    User().logged = false;
    await storage.delete(key: 'token');}
}