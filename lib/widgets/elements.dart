// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:chambas/constants/colores.dart';
import 'package:chambas/constants/input_decoration.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/providers/providers.dart';

class LoginForm extends StatelessWidget {
  final emailController;
  final passwordController;
  final loginForm;

  // ignore: use_key_in_widget_constructors
  const LoginForm(this.emailController, this.passwordController, this.loginForm);

  @override
  Widget build(BuildContext context) {
    return Center(     //SECCION BLANCA DE PÁGINA
            child: Form(
               key: loginForm.formkey, 
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                   Container(
                    height: 110,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
                    child: Image.asset('assets/full logo.png'),
                  ), 
                  Container(
                    padding: const EdgeInsets.only( bottom: 10),
                    child: Text("Ingresa a tu cuenta",
                        style: GoogleFonts.quicksand(
                            color: Colores.azul,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                      //                      height: MediaQuery.of(context).size.height * .55,
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
            );
         /*  ); */
  }
} 

Padding field(String description, TextEditingController controlador) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromRGBO(53, 62, 123, 0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese un dato valido';
              }
              return null;
            },
            controller: controlador,
            cursorWidth: 2,
            //controller: controlador,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.start,
            decoration: InputDecorations.authInputDecoration(hint: description),
          ),
        ),
      ),
    );
}

Padding emailField(String hint, TextEditingController controller) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromRGBO(53, 62, 123, 0.1),
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
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.start,
            decoration: InputDecorations.authInputDecoration(hint: hint),
          ),
        ),
      ),
    );
}


Padding passwordField(String hint, TextEditingController controller, LoginProvider login) {
  return   Padding(
    padding: const EdgeInsets.all(8.0),
      child: Container(
     margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
        color: const Color.fromRGBO(53, 62, 123, 0.1),),
        child: Padding( padding: const EdgeInsets.symmetric(horizontal: 30),
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
          style: const TextStyle(color: Colors.black),
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
     enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
     focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(style: BorderStyle.none))),
                                    ),
                   ),
                 ),
  );
}
