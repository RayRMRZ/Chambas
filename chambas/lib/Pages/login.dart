import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/providers/providers.dart';
import 'package:chambas/widgets/widgets.dart';
import 'package:chambas/pages/pages.dart';

import 'package:chambas/constants/colores.dart';

import '../models/user.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  static const String route = '/login';  //NECESARIO PARA LA NEAVEGACION

  const Login();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginProvider>(context);

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
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colores.azul,

            // AQUI VA A IR LA IMAGEN DINAMICA DE OFICIOS
          ),
           LoginForm(width,
                    height,
                    emailController,
                    passwordController,
                    loginForm), 

          Container(          //BOTÓN AMARILLO REGISTRARSE-------------------------
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10),
            child: InkWell(
              splashColor: Colores.crema,
              onTap: loginForm.isLoading ? null : () async{
                var email = emailController.text;
                var password = passwordController.text;
                
              if(loginForm.isValidForm()){
                User temp = User();
                loginForm.loadState = true;

                Auth signIn = await temp.signIn(email, password);

                loginForm.loadState = false;

                switch(signIn){
                  case Auth.bad: 
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Row(
                      children: const [
                        Icon(Icons.location_searching,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Verifique sus datos o registrese si aún no tiene cuenta'))],),  
                   backgroundColor: Colores.rojo,),
                  ); break;

                  case Auth.verify: 
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Row(
                      children: const [
                        Icon(Icons.attach_email_outlined,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Verifique su correo'))],),  
                   backgroundColor: Colores.azul,),
                  ); break;

                  case Auth.good: 
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Row(
                      children: const [
                        Icon(Icons.thumb_up_alt_outlined,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Bienvenido'))],),  
                   backgroundColor: Colores.amarillo,),);
                  Navigator.of(context).pushNamed(Categorias.route); break;
                  default: break;
                }
              }

              },
              child: Container(
                height: height * 0.1,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: loginForm.isLoading ? Colores.azul: Colores.amarillo,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Text(loginForm.isLoading ? 'Espere':'Ingresar',
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
