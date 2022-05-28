
import 'package:chambas/pages/pages.dart';
import 'package:flutter/material.dart';

class AppRoutes {

static  const initialRoute = '/check';

static Map<String, Widget Function(BuildContext)> routes = {
      'home'            : (context) => MyHomePage(),
      '/check'          : (context) => const CheckScreen(),
      Categorias.route  : (context) => Categorias(),
      Login.route       : (context) => const Login(),
      Register.route    : (context) => Register(),
      UserProfile.route : (context) => const UserProfile(), 
      FreeInfo.route    : (context) => const FreeInfo(),
      ProfileEdit.route : (context) => const ProfileEdit(),
      ToFreelance.route : (context) => const ToFreelance(),
      HistorialPage.route:(context) => const HistorialPage(),
      WritePost.route: (context) => const WritePost(),
};

}