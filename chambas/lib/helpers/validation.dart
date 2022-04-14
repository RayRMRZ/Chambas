
class Validation{

bool isCorrect({required String email}){
  var pattern = r'^[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[a-z]{2,3})$';
  var regExp = RegExp(pattern);
return regExp.hasMatch(email);
}

bool isFormatRight({required String password}){
  var pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  var regExp = RegExp(pattern); 
return regExp.hasMatch(password);
}

}