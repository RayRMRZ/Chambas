import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/widgets/widgets.dart';
import 'package:chambas/helpers/search.dart';
import 'package:chambas/helpers/JSON/helpers.dart';


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
      return  const SizedBox(width: double.infinity, height: 100, 
      child: Center(
        child: CupertinoActivityIndicator(radius: 18),
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
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20,),
          child: Text('Categorias',textAlign: TextAlign.center, style: GoogleFonts.quicksand(
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
      width: 120,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => showSearch(context: context, delegate: PerfilSearchDelegate()),
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: getImage(category.img),
              ),
            ),
          //const SizedBox(height: 10),
          Text(category.getName(), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
      
        ]),
      ),
    ); 
  }
}