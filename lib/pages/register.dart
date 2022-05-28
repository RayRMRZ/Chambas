import 'package:flutter/material.dart';

import 'package:chambas/constants/colores.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';

import 'package:provider/provider.dart';
import 'package:chambas/providers/providers.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chambas/services/authService.dart';
// ignore: use_key_in_widget_constructors
class Register extends StatefulWidget {
  static const String route = '/register'; //NECESARIO PARA LA NEAVEGACION
  
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  final loginForm = Provider.of<LoginProvider>(context);
    List<Widget> navBarItems = [
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorias',
        ),
      ),
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        onTap: () {
          Navigator.of(context).pushNamed(Login.route);
        },
        child: const NavBarItem(
          text: 'Ingresar',
        ),
      ),
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        onTap: () {
          //Navigator.of(context).pushNamed(Login.route);
        },
        child: const NavBarItem(
          text: 'Ayuda',
        ),
      ),
    ];
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              color: Colores.azul,
    
              // AQUI VA A IR LA IMAGEN DINAMICA DE DIFERENTES OFICIOS
            ),
    
            Center(     //SECCION BLANCA DE PÁGINA
              child: Container(
                //BODY------------------------------
                margin: const EdgeInsets.only(top: 120, bottom: 40),
                width: width * 0.9,
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
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25, bottom: 20),
                      child: Text("Crea Tu Cuenta",
                          style: GoogleFonts.quicksand(
                              color: Colores.azul,
                              fontSize: 45,
                              fontWeight: FontWeight.w700)),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height * .7,
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          clipBehavior: Clip.antiAlias,
                          controller: ScrollController(),
                          scrollDirection: Axis.vertical,
                          child: Form(
                            key: _formKey,
                            child: Column(
                            children: [
                              field('Nombres', nombresController),
                              field('Apellidos', apellidosController),
                              field('Correo Electronico', emailController),
                              passwordField('Contraseña',passwordController,loginForm),
                              field('Edad',edadController),
                              field('Dirección', direccionController),
                              field('Número telefónico', numeroTelController),
                              const SizedBox(height: 50,)
                            ],
                          )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    
            Container(          //BOTÓN AMARILLO REGISTRARSE-------------------------
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                splashColor: Colores.crema,
                onTap: () async{
                  
                  Map <String,String> persona = {
                    'email' : emailController.text,
                    'password' : passwordController.text,
                    'name': nombresController.text,
                    'lastname':apellidosController.text,
                    'address' : direccionController.text,
                    'age': edadController.text,
                    'phone': numeroTelController.text
                  };
                   
                  if (_formKey.currentState!.validate()) {
    
                    AuthService user = AuthService();
                   var registCorrect = await user.checkIn(
                     name: persona['name'] ?? "", 
                     lastname: persona['lastname'] ?? "", 
                     address: persona['address'] ?? "", 
                     age : persona['age'] ?? "", 
                     email: persona['email'] ?? "", 
                     password: persona['password'] ?? "" , 
                     phone: persona['phone'] ?? "" );
                     
                   if(registCorrect){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: 
                      Row(children: 
                   const [ 
                     FaIcon(Icons.emoji_people,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Usted ha sido registrado correctamente')),
                    ],),
                    backgroundColor: Colores.azul,),);
                      Navigator.of(context).pushNamed(Login.route);
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: 
                      Row(children: 
                   const [ 
                     FaIcon(FontAwesomeIcons.fileCircleQuestion,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Verifique sus datos correctamente')),
                    ],),
                    backgroundColor: Colores.rojo,),);
                  } 
                  }
                    
                },
                child: Container(
                  height: height * 0.1,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colores.amarillo,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Text("Registrarse",
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w400)),
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
      ),
    );
  }
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController password2Controller = TextEditingController();
TextEditingController direccionController = TextEditingController();
TextEditingController nombresController = TextEditingController();
TextEditingController apellidosController = TextEditingController();
TextEditingController edadController = TextEditingController();
TextEditingController numeroTelController = TextEditingController();