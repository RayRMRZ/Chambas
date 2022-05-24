
import 'package:chambas/constants/colores.dart';
import 'package:chambas/widgets/review_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:chambas/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class FreeInfo extends StatelessWidget {
  static const String route = '/info';
  const FreeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final freeprovider = Provider.of<FreelancerProvider>(context);
     return MaterialApp(
       home: Scaffold(
        body: CustomScrollView(
        slivers: [
          _CustomAppBar(freeprovider.onlyFreelancer.freelancer),
          SliverList(
            delegate: SliverChildListDelegate([
              _PersonalDesc(freeprovider.onlyFreelancer.freelancer),
                Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20,),
            child: Text('Mis redes sociales:',textAlign: TextAlign.left, style: GoogleFonts.quicksand(
                              color: Colors.black, fontWeight: FontWeight.w500)),),
            const Divider(),
              _SocialMedia(freeprovider.onlyFreelancer.freelancer),
              ReviewSlider(freeprovider.onDisplayReviews.reviews)
            ])
          )
          ],
        )
         ),
     );
  }
}

class _CustomAppBar extends StatelessWidget {

final Freelance freelance;


const _CustomAppBar(this.freelance);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colores.azul,
    expandedHeight: 280,
    floating: false,
    pinned: true,
    flexibleSpace:FlexibleSpaceBar(
      centerTitle: true,
      title: Text(freelance.getfullName(),style: GoogleFonts.quicksand(
               color: Colores.crema, 
               fontSize: 14,
               fontWeight: FontWeight.w800,
               shadows: <Shadow>[
                           const Shadow(
                              offset: Offset(2.0, -2.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              ],)
               ),
      background: PhotoViewGallery.builder(itemCount: 
      freelance.img.length, builder: (context,index) {
        return PhotoViewGalleryPageOptions(
          initialScale: PhotoViewComputedScale.contained * 0.7,
          imageProvider: NetworkImage(freelance.img[index]),
           heroAttributes: PhotoViewHeroAttributes(tag: freelance.img[index])
        );
      },
      customSize: const Size.square(1000),
       backgroundDecoration: const BoxDecoration(color: Colors.white),
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

       columnPerfil.add(Wrap(
         alignment:  WrapAlignment.start,
         spacing: 3.2,
         direction: Axis.vertical,
         children: categories,));
      columnPerfil.add(const SizedBox(height: 3,));
      /* columnPerfil.add(
          */

      return columnPerfil;
    }
    return Column(
      children: [ 
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [ Hero(
        tag: freelance.uid,
        child: Stack(
          children : [

          AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: const EdgeInsets.only(left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(placeholder: const AssetImage('assets/logo.png'),
              image: NetworkImage(freelance.usuario.img),
              height: 170,),
            ),
          ),

          Positioned(
            bottom: 1,
            right: 15,
            child: 
          Text(freelance.exp,
                  overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(
                  color: Colors.white, 
                  fontSize: 10,
                  fontWeight: FontWeight.w400)) ,)
          ]
        ),
      ), 
      
        const SizedBox(width: 20,),
      Center(
        child: Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getColumn()
        ),
      ),
        ],),
        
      ],
    );
  }
}

class _PersonalDesc extends StatelessWidget {
  final Freelance freelance;


const _PersonalDesc(this.freelance);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            children:  [

              Padding(
                padding: const EdgeInsets.only(left: 50, top: 15),
                child: Row(
                  children: [
                    Container(
                      height: 28,
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(freelance.skills[0],
                       overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.quicksand(
                       color: Colors.black, 
                       fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 5,),
                    Container(
                    height: 25,
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text("🟊"*int.parse(freelance.rank),
                style: GoogleFonts.notoSansSymbols2(
                fontSize: 11,
                color: Colores.amarillo, 
                fontWeight: FontWeight.w900)
                )
                )
                  ],
                ),
              ),

              const Divider(),
        _Perfil(freelance),
        AnimatedContainer(
          duration: const Duration(seconds: 2 ),
          padding: const EdgeInsets.only(left: 50, right: 50, top: 15, bottom: 5),
          child: Text( freelance.description, textAlign: TextAlign.justify, style:  GoogleFonts.roboto(
           color: Colors.black, 
           fontWeight: FontWeight.w300
          ),),),
        ],
          ),
        ),
      ],
    );
  }
}

class _SocialMedia extends StatelessWidget {
  
final Freelance freelance;

  const _SocialMedia(this.freelance) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Tooltip(
            message: 'Facebook',
            child: 
            (freelance.social.media.facebook != '') ?
            IconButton(icon: const FaIcon(FontAwesomeIcons.facebookSquare, size: 30,), splashRadius: 10, color: Colors.blue, onPressed: () async {
              if (!await launchUrl(Uri.parse(freelance.social.media.facebook))) throw 'Could not launch';
            },) : null,
          ),
          Tooltip(
            message: 'Whatsapp',
            child: 
            (freelance.social.media.whatsapp != '') ?
            IconButton(icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 30), splashRadius: 10,color: Colors.lime, onPressed: () async{
              if (!await launchUrl(Uri.parse(freelance.social.media.whatsapp))) throw 'Could not launch';
            },): null,
          ),
          Tooltip(
            message: 'Linkedin',
            child: 
            (freelance.social.media.linkedin != '') ?
            IconButton(icon: const FaIcon(FontAwesomeIcons.linkedin, size: 30), splashRadius: 10,color: Colors.blueGrey, onPressed: () async{
              if (!await launchUrl(Uri.parse(freelance.social.media.linkedin))) throw 'Could not launch';
            },) : null,
          ),
          Tooltip(
            message: 'GitHub',
            child: 
            (freelance.social.media.github != '') ?
            IconButton(icon: const FaIcon(FontAwesomeIcons.githubAlt, size: 30),splashRadius: 10,color: Colors.brown, onPressed: () async{
              if (!await launchUrl(Uri.parse(freelance.social.media.github))) throw 'Could not launch';
            },) : null,
          ),
          Tooltip(
            message: 'Youtube',
            child:
            (freelance.social.media.youtube!= '') ?
             IconButton(icon: const FaIcon(FontAwesomeIcons.youtube, size: 30),splashRadius: 10,color: Colors.red, onPressed: () async{
              if (!await launchUrl(Uri.parse(freelance.social.media.youtube))) throw 'Could not launch';
            },) : null,
          ),
          Tooltip(
            message: 'Instagram',
            child: 
            (freelance.social.media.instagram != '') ?
            IconButton(icon: const FaIcon(FontAwesomeIcons.instagram, size: 30),splashRadius: 10,color: const Color.fromARGB(255, 224, 132, 132), onPressed: () async{
              if (!await launchUrl(Uri.parse(freelance.social.media.instagram))) throw 'Could not launch';
            },): null,
          ),
          Tooltip(
            message: 'Twitter',
            child: 
            (freelance.social.media.twitter != '') ?
            IconButton(icon: const FaIcon(FontAwesomeIcons.twitter, size: 30), splashRadius: 10,color: Colors.lightBlue, onPressed: () async{
              if (!await launchUrl(Uri.parse(freelance.social.media.twitter))) throw 'Could not launch';
            },): null,
          ),
        ],
      );
  }
}