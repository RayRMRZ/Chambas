import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({hint}){
    return InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)));
  }
}