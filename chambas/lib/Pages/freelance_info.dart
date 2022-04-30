import 'package:chambas/constants/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:chambas/providers/providers.dart';

class FreeInfo extends StatelessWidget {
  static const String route = '/info';
  const FreeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final freeprovider = Provider.of<FreelancerProvider>(context);
     return Scaffold(
      body: CustomScrollView(
      slivers: [
        _CustomAppBar(freeprovider.onlyFreelancer.freelancer),
        SliverList(
          delegate: SliverChildListDelegate([
            _Perfil(freeprovider.onlyFreelancer.freelancer),
          ])
        )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

final Freelance freelance;

const _CustomAppBar(this.freelance);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
    expandedHeight: 280,
    floating: false,
    pinned: true,
    flexibleSpace:FlexibleSpaceBar(
      centerTitle: true,
      title: Text(freelance.exp,style: GoogleFonts.quicksand(
               color: Colors.white, 
               fontSize: 11,
               fontWeight: FontWeight.w800)),
      background: PhotoViewGallery.builder(itemCount: 
      freelance.img.length, builder: (context,index) {
        return PhotoViewGalleryPageOptions(
          initialScale: PhotoViewComputedScale.contained * 1.5,
          imageProvider: NetworkImage(freelance.img[index]),
           heroAttributes: PhotoViewHeroAttributes(tag: freelance.img[index])
        );
      },
      customSize: const Size.square(700),
       backgroundDecoration: const BoxDecoration(color: Colores.azul),
       loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / 100,
          ),
        ),
      ), ),
      )
    );
  }
}

class _Perfil extends StatelessWidget {
  final Freelance freelance;

  const _Perfil(this.freelance) ;

  @override
  Widget build(BuildContext context) {

 List<Widget> getColumn(){

  final List<Widget> columnPerfil = [];
  
  final List<Widget> categories = List.generate(freelance.categories.length, 
      (index) => Chip(
        avatar: CircleAvatar(
        backgroundColor: Colores.crema,
        child: Image.network(freelance.categories[index].img)  ,
        ),
        label: Text(freelance.categories[index].name,
                    overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.quicksand(
                    color: Colors.black, 
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
        backgroundColor: Colores.crema,));

       columnPerfil.add(Text(freelance.getfullName(),
          overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.quicksand(
               color: Colors.black, 
               fontWeight: FontWeight.w900)));

       columnPerfil.add(Text(freelance.exp,
          overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(
               color: Colors.black, 
               fontWeight: FontWeight.w300)));

       columnPerfil.add(Wrap(
         direction: Axis.vertical,
         children: categories,));

       columnPerfil.add(
         Text("🟊"*int.parse(freelance.rank),
          overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.notoSansSymbols2(
              fontSize: 20,
              color: Colores.amarillo, 
              fontWeight: FontWeight.w900)));

      return columnPerfil;
    }
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [ 
          Hero(
          tag: freelance.uid,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(placeholder: const AssetImage('assets/logo.png'),
            image: NetworkImage(freelance.usuario.img),
            height: 170,),
          ),
        ),

        const SizedBox(width: 20,),

        Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: getColumn()
        ),

/*         Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(freelance.getSkills(),
                    overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.quicksand(
                    color: Colors.black, 
                    fontWeight: FontWeight.w300)),
        ],
        ), */

        /* Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:  [
            Wrap(
              children: [
                Chip(
                avatar: const CircleAvatar(
                backgroundColor: Colores.crema,
                child: Icon(Icons.facebook, color: Colores.azul,) ),
                label: Text(freelance.social.media.facebook,
                    overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.quicksand(
                    color: Colors.black, 
                    fontWeight: FontWeight.w500)),
                backgroundColor: Colores.crema,),
              ],
            )
          ]
        ) */
        ],
      ),
    );
  }
}
