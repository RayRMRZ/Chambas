import 'package:flutter/material.dart';

import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySlider extends StatelessWidget {
  final List<ParseCategory> categories;
  final double width;

  const CategorySlider( this.width,
    { Key? key, 
     required this.categories
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(categories.isEmpty){
      return const SizedBox(width: double.infinity, height: 100, 
      child: Center(
        child: CircularProgressIndicator(),
        ),
      );
    } 
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 20,),
          child: Text('Categoria',textAlign: TextAlign.center, style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.w500)),),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_,int index){
                return _CatPosted(categories[index]);
              }),
          )
        ],
      ),
    );
  }
}
class _CatPosted extends StatelessWidget {
  final ParseCategory category;

  const _CatPosted(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('/'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              placeholder: const AssetImage('assets/logo.png'), 
              image: NetworkImage(category.img),
              fit: BoxFit.cover,),
          ),
        ),
        const SizedBox(height: 5),
        Text(category.getName(), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),

      ]),
    ); 
  }
}