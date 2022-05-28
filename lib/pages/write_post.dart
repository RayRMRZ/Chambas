import 'package:flutter/material.dart';

import 'package:chambas/constants/colores.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/widgets/perfil_image.dart';

import 'package:provider/provider.dart';
import 'package:chambas/providers/providers.dart';

import 'package:chambas/services/dataService.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:chambas/models/User.dart';
class WritePost extends StatefulWidget{
  static const String route = '/post';
 const WritePost();
  @override State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<WritePost>{

  TextEditingController viewController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  
  User user = User();
  FocusNode writingTextFocus = FocusNode();

  double value = 0;

  @override
  Widget build(BuildContext context) {
    final freeprovider = Provider.of<FreelancerProvider>(context);
    final free = freeprovider.onlyFreelancer.freelancer;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colores.rojo,
        title: const Text('Review'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              
              if(user.logged){
              Map <String, String> review = {};

              review = {
                "usuario" : user.uid,
	              "points"  : value.toInt().toString(),
	              "title"   : titleController.text,
	              "view"    : viewController.text,
	              "freelancer" : free.uid
              };
              DataService usuario = DataService();
              usuario.postReview(review);
              }
            },
            child: const Text('Enviar',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: Stack(
        children:  <Widget>[
           SingleChildScrollView(
             child: Column(
               children: <Widget>[
                 SizedBox(
                     width: size.width,
                     height: size.height - MediaQuery.of(context).viewInsets.bottom - 80,
                     child: Padding(
                       padding: const EdgeInsets.only(right:14.0,left:10.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                      
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: SizedBox(
                                     width: 60,
                                     height: 60,
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(1000),
                                       child: getImage(free.usuario.img)),
                                 ),
                               ),
                               Text( free.usuario.name +' '+ free.usuario.lastname, textAlign: TextAlign.center,
                                       style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 18, 
                                          fontWeight: FontWeight.w500)),
                             ],
                           ),
                          TextFormField(
                             decoration: const InputDecoration(
                               border: InputBorder.none,
                               hintText: 'Titulo',
                               hintMaxLines: 1,
                             ),
                             controller: titleController,
                             keyboardType: TextInputType.text,
                             maxLines: null,
                          ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RatingStars(
                                value: value,
                                onValueChanged: (v) {
                                    setState(() {
                                    value = v;
                                });
                                  },
                                            starBuilder: (index, color) => Icon(
                                                  Icons.star,
                                                  color: color,
                                                ),
                                 starCount: 5,
                                 starSize: 20,
                                 valueLabelColor: Colores.crema,
                                 valueLabelTextStyle: const TextStyle(
                                     color: Colores.amarillo,
                                     fontWeight: FontWeight.w700,
                                     fontStyle: FontStyle.normal,
                                     fontSize: 12.0),
                                 valueLabelRadius: 10,
                                 maxValue: 5,
                                 starSpacing: 2,
                                 maxValueVisibility: true,
                                 valueLabelVisibility: true,
                                 animationDuration: const Duration(milliseconds: 1000),
                                 valueLabelPadding:
                                     const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                 valueLabelMargin: const EdgeInsets.only(right: 8),
                                 starOffColor: const Color(0xffe7e8ea),
                                 starColor: Colores.amarillo,
                                                 ),
                              ],
                            ),
                           
                           TextFormField(
                             autofocus: true,
                             focusNode: writingTextFocus,
                             decoration: const InputDecoration(
                               border: InputBorder.none,
                               hintText: 'Comentarios...',
                               hintMaxLines: 4,
                             ),
                             controller: viewController,
                             keyboardType: TextInputType.multiline,
                             maxLines: null,
                           ),
                           /* _postImageFile != null ? Image.file(_postImageFile,fit: BoxFit.fill,) :
                           Container(), */
                         ],
                       ),
                     )
                 ),
               ],
             ),
           ), 
        ],
      ),
    );
  }
}