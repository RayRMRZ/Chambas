import 'package:chambas/Pages/UserProfile.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/constants/colores.dart';
import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';
import 'package:chambas/models/user.dart';

// ignore: use_key_in_widget_constructors
class ProfileEdit extends StatefulWidget {
  static const String route = '/editar_perfil'; //NECESARIO PARA LA NEAVEGACION

  const ProfileEdit();
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorias',
        ),
      ),
      
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(UserProfile.route);
        },
        child: const NavBarItem(
          text: 'Perfil',
        ),
      ),
    ];
    
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
           color: Colors.grey.withOpacity(0.1),
             alignment: Alignment.bottomCenter,
             child: Padding(
               padding: const EdgeInsets.only(top: 110),
               child: Column(
                 children: [
                   Text("Aqui van tus widgets"),
                   //   AQUI IRAN TUS WIDGETS AZAEL


                 ],
               ),
             ),
           ),

          AnimatedContainer( // RESPONSIVE NAVBAR EN MOBILES
            //NAVBAR---------------------
            margin: const EdgeInsets.only(top: 79.0),
            duration: const Duration(milliseconds: 375),
            curve: Curves.ease,
            height: (width < 800.0) ? collapsableHeight : 0.0,
            width: double.infinity,
            color: Colores.azul,
            child: SingleChildScrollView(
              child: Column(
                children: navBarItems,
              ),
            ),
          ),
          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(color: Colores.azul, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/circle logo.png')),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  if (width < 800.0) {
                    return NavBarButton(
                      onPressed: () {
                        if (collapsableHeight == 0.0) {
                          setState(() {
                            collapsableHeight = 240.0;
                          });
                        } else if (collapsableHeight == 240.0) {
                          setState(() {
                            collapsableHeight = 0.0;
                          });
                        }
                      },
                    );
                  } else {
                    return Row(
                      children: navBarItems,
                    );
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}