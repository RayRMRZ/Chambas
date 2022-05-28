
import 'package:flutter/material.dart';

import '../constants/colores.dart';

class NotificationService{
  static late GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar ( 
    {required String msg, 
     required IconData icon,  
     required Color backgroundColor}) { final snackbar = SnackBar(content: 
                    Row(children: 
                    [ Icon(icon,color: Colores.crema,),
                        const SizedBox(width: 20,),
                        Expanded(child: Text(msg)),
                    ],),
                    backgroundColor: backgroundColor,);

    msgKey.currentState!.showSnackBar(snackbar);
  }
}