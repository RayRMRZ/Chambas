
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colores.dart';

Material botonCircular(String imagen, String texto, String ruta, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        hoverColor: Color.fromRGBO(100, 100, 100, 0.08),
        onTap: () {
          Navigator.of(context).pushNamed(ruta);
        },
        child: Container(
          height: 100,
          width: 70,
          padding: EdgeInsets.symmetric(vertical: 20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                padding: EdgeInsets.all(20),
                child: Image.network(imagen),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ]),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Text(texto,textAlign: TextAlign.center, style: GoogleFonts.quicksand(
                      color: Colores.azul, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }