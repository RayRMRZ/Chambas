import 'package:chambas/widgets/card.dart';
import 'package:flutter/material.dart';

import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularFrelancers extends StatelessWidget {
final List<Freelance> popular;
String title;

   PopularFrelancers( this.title, 
    { Key? key, 
     required this.popular
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
       height: 200,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,//Cuantos elementos por fila
         children: [
           Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20,),
          child: Text(title,textAlign: TextAlign.center, style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.w500)),),
           Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popular.length,
              itemBuilder: (_,int index){
                return perfilCard(context,
                 image: popular[index].usuario.img, 
                 skills: popular[index].getAct(), 
                 name: popular[index].getfullName(), 
                 stars: int.parse(popular[index].rank), uid: popular[index].uid,
                 route: '/', );
              }),
          )
         ],
       ),
     );
  }
}