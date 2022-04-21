import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
GlobalKey<FormState> formkey = GlobalKey<FormState>();

bool _password = true;
bool _loading = false;

String email = '';
String password = '';

bool isValidForm(){
  return formkey.currentState?.validate() ?? false;
}
bool get isLoading => _loading;

set loadState(bool state){
_loading = state;
notifyListeners();
}

bool get isHiddenPass => _password;

set passState(bool state){
  _password = state;
  notifyListeners();
}
} 