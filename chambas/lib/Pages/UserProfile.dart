import 'package:chambas/Pages/pages.dart';
import 'package:chambas/Pages/toFreelanceForm.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/constants/colores.dart';
import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';
import 'package:chambas/models/user.dart';
import 'package:provider/provider.dart';

import '../models/sesion.dart';
import 'ProfileEdit.dart';

// ignore: use_key_in_widget_constructors
class UserProfile extends StatefulWidget {
  static const String route = '/perfil'; //NECESARIO PARA LA NEAVEGACION

  const UserProfile();
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);

    List<Widget> navBarItems = [
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorias',
        ),
      ),
    
      if(User().getLogged() == true) IconButton(onPressed: () async{
        await session.logout();
        Navigator.pushNamed(context, Login.route);
      }, icon: Icon(Icons.logout,color: Colores.crema,),)
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
                   Expanded(
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       height: MediaQuery.of(context).size.height * .7,
                       alignment: Alignment.topCenter,
                       child: SingleChildScrollView(
                         clipBehavior: Clip.antiAlias,
                         controller: ScrollController(),
                         scrollDirection: Axis.vertical,
                         child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                               child: SizedBox(
                                 height: 150,
                                 width: 150,
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(100),
                                   child: FadeInImage(
                                       placeholder: const AssetImage('assets/logo.png'), 
                                       image: NetworkImage(User().img),
                                       fit: BoxFit.cover,
                                   ),
                                 ),
                               ),
                             ),
                             
                             Text( User().name + " " + User().lastname,
                               style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w800)),

                            Text( User().emailUsr,
                               style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500)),
                            
                            const SizedBox(height: 10,),

                             InkWell(
                               onTap: () => Navigator.of(context).pushNamed(ProfileEdit.route),
                               borderRadius: BorderRadius.circular(5),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   const SizedBox(width: 10,),
                                   const Icon(Icons.edit_note_rounded, color: Colores.azul,),
                                   const SizedBox(width: 5,),
                                   Text( "Editar perfil",
                                     style: GoogleFonts.quicksand(
                                        color: Colores.azul,
                                        fontWeight: FontWeight.w500)),
                                   const SizedBox(width: 10,),
                                  
                                 ],
                               ),
                             ),

                             const Divider( height: 20,),
                             infoPersonal(User().name, User().lastname, User().emailUsr, User().age, User().address, User().phone),

                             if(User().role != 'FREE_ROLE') InkWell(
                               onTap: () => Navigator.of(context).pushNamed(ToFreelance.route),
                               borderRadius: BorderRadius.circular(5),
                               child: Container(
                                 decoration: BoxDecoration(
                                   color: Colores.amarillo,
                                   borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                   child: Text( "¡Quiero ofrecer mi servicio!",
                                            style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600)),
                                 ),
                               ),
                             ),
                           ],
                         )
                         ),
                       ),
                     ),
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

  Container infoPersonal(String nombre, String apellido, String email, String edad, String direccion, String phone) {
    
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text("Nombre(s): "+nombre,
            style: GoogleFonts.quicksand(
                color: Colors.black, 
                fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text( "Apellidos: "+apellido,
            style: GoogleFonts.quicksand(
                color: Colors.black, 
                fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text( "Email: "+email,
            style: GoogleFonts.quicksand(
                color: Colors.black, 
                fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text( "Edad: "+edad,
            style: GoogleFonts.quicksand(
                color: Colors.black, 
                fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text( "Direccion: "+direccion,
            style: GoogleFonts.quicksand(
                color: Colors.black, 
                fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text( "Telefono: "+phone,
            style: GoogleFonts.quicksand(
                color: Colors.black, 
                fontWeight: FontWeight.w500)),
          ),
        ],  
      ),
    );
  }
}