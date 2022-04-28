  
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colores.dart';

  tarjetaPerfil(String imagen, String profesion, String name, int stars, String ruta, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        hoverColor: const Color.fromRGBO(100, 100, 100, 0.08),
        onTap: () {
          Navigator.of(context).pushNamed(ruta);
        },
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
          child: Center(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric( horizontal: (width > 700.0)? 25 : 15, vertical: (width > 700.0)? 15 : 10 ),
                  child: Image.asset(imagen),
                ),
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Expanded(
                      child: AutoSizeText(profesion,
                      minFontSize: 5,
                      maxFontSize: 15,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.quicksand(
                          color: Colors.black, 
                          fontWeight: FontWeight.w900)),
                    ),
                    Expanded(
                      child: AutoSizeText(name,
                      minFontSize: 5,
                      maxFontSize: 15,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.quicksand(
                          color: Colors.black, 
                          fontWeight: FontWeight.w300)),
                    ),
                    
                    Expanded(
                      child: AutoSizeText("🟊"*stars,
                      minFontSize: 15,
                      maxFontSize: 20,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.notoSansSymbols2(
                          fontSize: 20,
                          color: Colores.amarillo, 
                          fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }