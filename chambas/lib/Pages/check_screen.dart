import 'package:flutter/material.dart';

import 'package:chambas/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:chambas/models/Session.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sesion = Provider.of<Session>(context, listen: false); 
    return Scaffold(
      body:  Center(
       child: FutureBuilder(
         future: sesion.readToken(),
         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
           if(snapshot.hasData) {
             return const CircularProgressIndicator();
           }
           // ignore: unrelated_type_equality_checks
           if(snapshot.hasData == ''){
           Future.microtask(() {
             Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const Login(),
              transitionDuration: const Duration(seconds: 0),
              ),
            );}
          );
          }else{
            Future.microtask(() {
             Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
              transitionDuration: const Duration(seconds: 0),
              ),
            );}
          );
          }

      
           return Container();

         },
       ),
      ),
    );
  }
}

