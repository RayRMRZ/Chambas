  
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colores.dart';

  perfilCard(String imagen, String profesion, String name, int stars, String ruta, BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.only( left: 10, right: 10),
          child: Container(
            height: 60,
            width: 350,
            padding: const EdgeInsets.symmetric(vertical: 18),
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
                    padding: const EdgeInsets.symmetric( horizontal: 3, vertical: 3 ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FadeInImage(
                      placeholder: const AssetImage('assets/logo.png'), 
                      image: NetworkImage(imagen),
                      //fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AutoSizeText(name,
                        minFontSize: 12,
                        maxFontSize: 15,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.quicksand(
                            color: Colors.black, 
                            fontWeight: FontWeight.w900)),
                      ),
                      Expanded(
                        child: AutoSizeText(profesion,
                        minFontSize: 11,
                        maxFontSize: 15,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            color: Colors.black, 
                            fontWeight: FontWeight.w300)),
                      ),
                      
                      Expanded(
                        child: AutoSizeText("🟊"*stars,
                        minFontSize: 15,
                        maxFontSize: 20,
                        textAlign: TextAlign.justify,
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
      ),
    );
  }