
import 'package:flutter/cupertino.dart';

import 'package:chambas/models/User.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Session extends ChangeNotifier{

  String _token = '';
  String _uid = '';
  final storage = const FlutterSecureStorage();
  
  Session();
  set token(tkn){ _token = tkn;}

  set uid(uid){
    _uid = uid;
  }

  saveTokenStorage() async{
    await storage.write(key: 'token', value: _token);
  }
  Future <String> readToken() async{
    return await storage.read(key: 'token') ?? '';
  }

  Future logout()async{
    User().logged = false;
    await storage.delete(key: 'token');}

  saveUidStorage() async{
    await storage.write(key: 'uid', value: _uid);
  }
}