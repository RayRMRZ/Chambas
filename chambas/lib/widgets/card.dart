import 'dart:developer';

import 'package:chambas/helpers/history.dart';
import 'package:chambas/widgets/perfil_image.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chambas/providers/providers.dart';
import 'package:chambas/constants/colores.dart';
import 'package:chambas/pages/pages.dart';

  perfilCard(BuildContext context, 
  {required String image, required String skills, 
   required String name, required int stars, 
   required String route, required String uid}) {

final freeprovider = Provider.of<FreelancerProvider>(context);
  
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        hoverColor: const Color.fromRGBO(100, 100, 100, 0.08),
        onTap: () async{
          bool isInitialized = await freeprovider.getOnDisplayInfo(uid);
          if(isInitialized){
            Historial historial = Historial();
            historial.add(uid, freeprovider.onlyFreelancer.freelancer.usuario.img, freeprovider.onlyFreelancer.freelancer.getfullName());
            log(historial.usuarios.toString());
          Navigator.of(context).pushNamed(FreeInfo.route,arguments: freeprovider.onlyFreelancer);
          }       
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
                    padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 3 ),
                    child: Hero(
                      tag: uid,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: getImage(image),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: AutoSizeText(skills,
                        minFontSize: 11,
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
      ),
    );
  }