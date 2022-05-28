import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/widgets/widgets.dart';
import 'package:chambas/helpers/JSON/helpers.dart';

class ReviewSlider extends StatelessWidget {
  final List<Review> comments;
  // ignore: use_key_in_widget_constructors
  const ReviewSlider(this.comments) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
       height: 292,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,//Cuantos elementos por fila
         children: [
           Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20,),
          child: Text('Reviews',textAlign: TextAlign.center, style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.w500)),),
          const Divider(),
           Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comments.length,
              itemBuilder: (_,int index){
                return ReviewItem(
                  title: comments[index].title,
                  name: comments[index].usuario.name+" "+comments[index].usuario.lastname ,
                  review: comments[index].view,
                  stars: comments[index].points,
                  image: comments[index].usuario.img,
                  meta: comments[index].meta);
              }),
          )
         ],
       ),
     );
  }
}
