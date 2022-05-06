import 'dart:io';

import 'package:flutter/cupertino.dart';

Widget getImage(String? picture){
if(picture == null){
  return const Image(image: AssetImage('assets/logo.png'), fit: BoxFit.cover,);
}else if (picture.startsWith('http')){
  return FadeInImage(
                placeholder: const AssetImage('assets/logo.png'), 
                image: NetworkImage(picture) ,
                fit: BoxFit.cover,);
}
return Image.file(File(picture), fit: BoxFit.cover,);
}