import 'package:auto_size_text/auto_size_text.dart';
import 'package:chambas/constants/colores.dart';
import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:chambas/widgets/perfil_image.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewItem extends StatelessWidget {
  final String image;
  final String review;
  final String title;
  final String name;
  final Meta meta; 
  final int stars; 
  // ignore: use_key_in_widget_constructors
  const ReviewItem({required this.title, required this.name ,required this.review ,required this.stars,required this.image, required this.meta});

  @override
  Widget build(BuildContext context) {
    int likes = meta.likes;
    int dislikes = meta.dislikes;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        hoverColor: const Color.fromRGBO(100, 100, 100, 0.08),
        onTap: () => {},
        child: Padding(
          padding: const EdgeInsets.only( left: 10, right: 10),
          child: Container(
            height: 250,
            width: 400,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: 
            [
            const SizedBox(width: 20,),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Tooltip(
                        message: name,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: getImage(image),),
                      ),
                    ),
                  const SizedBox(width: 60,),
                  Expanded(
                      child: AutoSizeText(title,
                      minFontSize: 5,
                      maxFontSize: 12,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                          color: Colors.black, 
                          fontWeight: FontWeight.w500)),
                    ),
                  Expanded(
                      child: AutoSizeText("🟊"*stars,
                      minFontSize: 5,
                      maxFontSize: 15,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.notoSansSymbols2(
                          fontSize: 15,
                          color: Colores.amarillo, 
                          fontWeight: FontWeight.w900)),
                    ),
                    
            ],),),
                  Expanded(
                    child: Column(
                      children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(review, textAlign: TextAlign.justify,overflow: TextOverflow.fade, 
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 13, 
                          fontWeight: FontWeight.w300)),
                      ),
                    ],),
                  ),
                  Row( 
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      IconButton(onPressed: ()=>{
                        meta.likes += 1
                      }, icon: Badge(
                        badgeContent: Text(likes.toString(), style: const TextStyle(color: Colores.crema),),
                        badgeColor: Colores.rojo,
                        animationType: BadgeAnimationType.slide,
                        child: const  FaIcon(FontAwesomeIcons.thumbsUp, color: Colores.rojo,))),
                      IconButton(onPressed: ()=>{
                        meta.dislikes += 1
                      }, icon: Badge(
                        badgeContent: Text(dislikes.toString(), style: const TextStyle(color: Colores.crema),),
                        badgeColor: Colores.azul,
                        child: const FaIcon(FontAwesomeIcons.thumbsDown,color: Colores.azul )))
                    ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}