
import 'package:chambas/constants/colores.dart';
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
     return Scaffold(
      body: CustomScrollView(
      slivers: [
        _CustomAppBar(freeprovider.onlyFreelancer.freelancer),
        SliverList(
          delegate: SliverChildListDelegate([
            _PersonalDesc(freeprovider.onlyFreelancer.freelancer),
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
      title: Text(freelance.getfullName(),style: GoogleFonts.quicksand(
               color: Colores.crema, 
               fontSize: 14,
               fontWeight: FontWeight.w900,
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
         alignment:  WrapAlignment.center,
         spacing: 3.2,
         direction: Axis.vertical,
         children: categories,));
      columnPerfil.add(const SizedBox(height: 10,));
      columnPerfil.add(
         Row(
        children: [
          IconButton(icon: const FaIcon(FontAwesomeIcons.facebookSquare, size: 20,), splashRadius: 10, color: Colors.blue, onPressed: () async {
            if (!await launchUrl(Uri.parse(freelance.social.media.facebook))) throw 'Could not launch';
          },),
          IconButton(icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 20), splashRadius: 10,color: Colors.lime, onPressed: () async{
            if (!await launchUrl(Uri.parse("whatsapp://send?phone=+522382754698&text=Usted ha sido hackeado"))) throw 'Could not launch';
          },),
          IconButton(icon: const FaIcon(FontAwesomeIcons.githubAlt, size: 20),splashRadius: 10,color: Colors.brown, onPressed: () async{
            if (!await launchUrl(Uri.parse(freelance.social.media.github))) throw 'Could not launch';
          },),
          IconButton(icon: const FaIcon(FontAwesomeIcons.youtube, size: 20),splashRadius: 10,color: Colors.red, onPressed: () async{
            if (!await launchUrl(Uri.parse(freelance.social.media.facebook))) throw 'Could not launch';
          },),
          IconButton(icon: const FaIcon(FontAwesomeIcons.instagram, size: 20),splashRadius: 10,color: const Color.fromRGBO(244, 54, 235, 1), onPressed: () async{
            if (!await launchUrl(Uri.parse(freelance.social.media.instagram))) throw 'Could not launch';
          },),
        ],
      ),);

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
            child: Text(freelance.exp,
                  overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(
                  color: Colors.white, 
                  fontSize: 10,
                  fontWeight: FontWeight.w400)),
          ),
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
                padding: const EdgeInsets.only(left: 50),
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
          child: Text("""Soy un diseñador Gráfico de Tehuacán, Puebla. He aprendido este oficio por mi propia cuenta, ya que es algo que desde que lo descubrí, me ha gustado mucho. No tengo licenciatura pero sí los conocimientos necesarios para crear la imagen de tu negocio y darle el branding que necesita, brindando un servicio profesional con comunicacion clara de su vision sobre el flyer, logo, o diseño que necesite.
          """, textAlign: TextAlign.justify, style:  GoogleFonts.roboto(
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
