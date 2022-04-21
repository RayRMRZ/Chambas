import 'package:flutter/material.dart';

import '../constants/colores.dart';
import 'package:chambas/constants/input_decoration.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/providers/providers.dart';

class LoginForm extends StatelessWidget {
  final width;
  final height;
  final emailController;
  final passwordController;
  final loginForm;

  const LoginForm(this.width,this.height, this.emailController, this.passwordController, this.loginForm);

  @override
  Widget build(BuildContext context) {
    return Center(     //SECCION BLANCA DE PÁGINA
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
              child: Form(
                 key: loginForm.formkey, 
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            emailField("Email / Correo Electronico", emailController),
                            passwordField('Contraseña',passwordController,loginForm),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          );
  }
} 
Padding field(String descripcion, TextEditingController controlador) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color.fromRGBO(53, 62, 123, 0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese un dato valido';
              }
            },
            controller: controlador,
            cursorWidth: 2,
            //controller: controlador,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: descripcion,
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none))),
          ),
        ),
      ),
    );
}

Padding emailField(String hint, TextEditingController controller) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color.fromRGBO(53, 62, 123, 0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
            return regExp.hasMatch(value ?? '')
            ? null
            :'El valor ingresado no es un correo electrónico';
            },
            controller: controller,
            cursorWidth: 2,
            //controller: controlador,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.start,
            decoration: InputDecorations.authInputDecoration(hint: hint),
          ),
        ),
      ),
    );
}


Padding passwordField(String hint, TextEditingController controller, LoginProvider login) {
  return   Padding(
    padding: EdgeInsets.all(8.0),
      child: Container(
     margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
        color: Color.fromRGBO(53, 62, 123, 0.1),),
        child: Padding( padding: EdgeInsets.symmetric(horizontal: 30),
                 child: TextFormField( obscureText: login.isHiddenPass,
            controller: controller,
           cursorWidth: 2,
          validator: (value) {
                String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                ? null
            :'La contraseña debe tener al menos 8 caracteres, una letra mayuscula, un número y un simbolo especial';
          },
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.start,
         decoration: InputDecoration(
         suffixIcon: IconButton(
         icon: Icon( login.isHiddenPass ? Icons.visibility_rounded : Icons.visibility_off_rounded,
           color: Colores.azul,),
        onPressed:() => {
                         login.passState = !login.isHiddenPass,
                        }),
        hintText: hint,
       hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5),),
     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none))),
                                    ),
                   ),
                 ),
  );
}
