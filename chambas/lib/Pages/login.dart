// ignore_for_file: use_key_in_widget_constructors, duplicate_ignore, prefer_const_constructors

import 'package:chambas/Pages/register.dart';
import 'package:chambas/constants/colores.dart';
import 'package:chambas/widgets/navBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/elementos.dart';
import 'categorias.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  static const String route = '/login';  //NECESARIO PARA LA NEAVEGACION

  const Login();
  @override
  _LoginState createState() => _LoginState();
}
bool _passwordVisible = false;

class _LoginState extends State<Login> {
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> navBarItems = [
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorías',
        ),),

      InkWell(
        mouseCursor: SystemMouseCursors.help,
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Register.route);
        },
        child: const NavBarItem(
          text: 'Registrarse',
        ),),

        InkWell(
        mouseCursor: SystemMouseCursors.help,
        splashColor: Colors.white60,
        onTap: () {
          //Navigator.of(context).pushNamed(Register.route);
        },
        child: const NavBarItem(
          text: 'Ayuda',
        ),),
    ];

    
    
    String _emailLogin = emailController.text;
    String _passwordLogin = passwordController.text;
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colores.azul,

            // AQUI VA A IR LA IMAGEN DINAMICA DE OFICIOS
          ),
          Center(     //SECCION BLANCA DE PÁGINA
            child: Container(
              //BODY------------------------------
              margin: const EdgeInsets.only(top: 120, bottom: 40),
              width: width < 700.0 ? width*0.9 : width*0.5,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 20),
                    child: Text("Ingresa a tu cuenta",
                        style: GoogleFonts.quicksand(
                            color: Colores.azul,
                            fontSize: 35,
                            fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * .55,
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          campoSencillo("Email / Correo Electronico", emailController),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Color.fromRGBO(53, 62, 123, 0.1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: TextFormField(
                                  
                                  obscureText: !_passwordVisible,
                                  controller: passwordController,
                                  cursorWidth: 2,
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon( _passwordVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                      color: Colores.azul,
                                      ),
                                      onPressed: () => setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                })),
                                    hintText: "Contraseña",
                                    hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5),),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none))
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(          //BOTÓN AMARILLO REGISTRARSE-------------------------
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10),
            child: InkWell(
              splashColor: Colores.crema,
              onTap: () {
                //Navigator.of(context).pushNamed(       .route);  
              },
              child: Container(
                height: height * 0.1,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colores.amarillo,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Text("Ingresar",
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),

          AnimatedContainer(
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
            decoration: BoxDecoration(
              color: Colores.azul, boxShadow: [
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

                //txtSearch(" ¿Qué servicio necesita?"),

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
