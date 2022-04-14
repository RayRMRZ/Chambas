// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


Padding campoSencillo(String descripcion, TextEditingController controlador) {
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

