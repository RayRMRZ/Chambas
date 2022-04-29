import 'package:chambas/widgets/card.dart';
import 'package:flutter/material.dart';

import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularFrelancers extends StatelessWidget {
final List<Freelance> popular;
final double width;

  const PopularFrelancers( this.width,
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
          child: Text('Profesionistas destacados',textAlign: TextAlign.center, style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.w500)),),
           Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popular.length,
              itemBuilder: (_,int index){
                return perfilCard(popular[index].img[0], popular[index].getAct(), popular[index].getfullName(), 5, '/', context);
              }),
          )
         ],
       ),
     );
  }
}