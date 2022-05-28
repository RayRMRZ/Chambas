
import 'package:flutter/material.dart';
import 'package:chambas/services/authService.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';

import 'package:multiselect/multiselect.dart';
import 'package:chambas/constants/colores.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: use_key_in_widget_constructors
class ToFreelance extends StatefulWidget {
  
  static const String route = '/toFreelance'; //NECESARIO PARA LA NEAVEGACION

  const ToFreelance();
  @override
  _ToFreelanceState createState() => _ToFreelanceState();
}

class _ToFreelanceState extends State<ToFreelance> {
  bool _hasWhatsapp = true;
  bool _hasFacebook = false;
  bool _hasLinkedin = false;
  bool _hasGithub   = false;
  bool _hasYoutube  = false;
  bool _hasInstagram = false;
  bool _hasTwitter = false;
  
  String exp = "menos de 1";
  String categoria = 'Agricultura';
  List<String> categoriasID = [];
  List<String> skillsSelected = [];
  List<String> categoriasSelected = [];

  TextEditingController descController      = TextEditingController();
  TextEditingController facebookController  = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController   = TextEditingController();
  TextEditingController githubController    = TextEditingController();
  TextEditingController whatsController     = TextEditingController();
  TextEditingController twitterController   = TextEditingController();
  TextEditingController linkedinController  = TextEditingController();
  TextEditingController numeroTelController = TextEditingController();  

  @override
  Widget build(BuildContext context) {
  
    List<Widget> navBarItems = [
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorias',
        ),
      ),
    ];
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colores.rojo,
          ),

          Center( 
            child: Container(
              //BODY------------------------------
              margin: const EdgeInsets.only(top: 120, bottom: 40),
              width: width * 0.9,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 0), 
                  ),
                ],
              ),
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    child: Text("!Hola estás apunto de ofrecer tu servico!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            color: Colores.azul,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * .7,
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        child: Form(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            dropDowntitle(),
                            const SizedBox(height: 30),

                            AutoSizeText('Describe lo que haces: ',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),

                            const Divider(),

                            field('Me dedico a...',descController),

                            dropDownSkills(),

                            dropDownExperiencia(),
                            const SizedBox(height: 10),

                            dropDownCategories(),
                            const SizedBox(height: 10),

                             AutoSizeText('¿Tienes redes sociales?',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),

                            const Divider(),

                            CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,  
                            value: _hasWhatsapp,
                            title: (_hasWhatsapp) ? field('Número de whatsapp (+52):', whatsController) :
                            AutoSizeText('WhatsApp',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            checkColor: Colores.crema, onChanged: (value){
                              _hasWhatsapp= value!;
                              setState(() {});}),
                            

                            CheckboxListTile(value: _hasFacebook,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: (_hasFacebook) ? field('Link de su Facebook', facebookController):
                            AutoSizeText('Facebook',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            checkColor: Colores.crema, onChanged: (value){
                              _hasFacebook = value!;
                              setState(() {});}),

                            CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: (_hasLinkedin) ? field('Link de su LinkedIn', linkedinController):
                            AutoSizeText('LinkedIn',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            value: _hasLinkedin, 
                            checkColor: Colores.crema,onChanged: (value){
                            _hasLinkedin = value!;
                              setState(() {});}),

                            CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: (_hasGithub) ? field('Link de su Github', githubController):
                            AutoSizeText('GitHub',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            value: _hasGithub,
                            checkColor: Colores.crema, onChanged: (value){
                              _hasGithub = value!;
                              setState(() {});}),

                            CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title:(_hasYoutube) ? field('Link de su Youtube', youtubeController):
                            AutoSizeText('Youtube',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            value: _hasYoutube,
                            checkColor: Colores.crema, onChanged: (value){
                              _hasYoutube = value!;
                              setState(() {});}),

                              CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: (_hasInstagram) ? field('Link de su Instagram', instagramController):
                            AutoSizeText('Instagram',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            value: _hasInstagram,
                            checkColor: Colores.crema, onChanged: (value){
                              _hasInstagram = value!;
                              setState(() {});}),

                              CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: (_hasTwitter)? field('Link de su Twitter', twitterController):
                            AutoSizeText('Twitter',
                                  minFontSize: 8,
                                  maxFontSize: 15,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500),),
                            activeColor: Colores.rojo,
                            value: _hasTwitter,
                            checkColor: Colores.crema, onChanged: (value){
                              _hasTwitter = value!;
                              setState(() {});}),
                              const SizedBox(height: 70),
                          ],
                        )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(          //BOTÓN AMARILLO REGISTRARSE-------------------------
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              splashColor: Colores.crema,
              onTap: () async{
                  const storage =  FlutterSecureStorage();
                  AuthService user = AuthService();
                  
                  var media = {
                    "media" : {
                    "facebook" : facebookController.text,
                    "instagram": instagramController.text,
                    "github"   : githubController.text,
                    "youtube"  : youtubeController.text,
                    "whatsapp" : 
                    "whatsapp://send?phone=+52${whatsController.text}",
                    "linkedin" : linkedinController.text,
                    "twitter"  : twitterController.text,}
                  };

                  String now = await storage.read(key: 'uid') ?? '';

                  for(var i in categoriasSelected){
                      categoriasID.add(categoryToID(value: i));
                  }
                  
                  skillsSelected.insert(0, categoria);
                 
                  
                    var isFreelance = await user.toFreelance( 
                    desc: descController.text, 
                    exp: '$exp años de experiencia',
                    skills: skillsSelected, 
                    media: media, 
                    categories: categoriasID, 
                    usuario: now,); 

              categoriasID = []; skillsSelected = [];
                
              if(isFreelance){
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: 
                      Row(children: 
                   const [ 
                     FaIcon(Icons.radar,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Ahora puede ser encontrado como prestador de servicios')),
                    ],),
                    backgroundColor: Colores.azul,)
                      ,);
                      Navigator.of(context).pushNamed(UserProfile.route);
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: 
                      Row(children: 
                   const [ FaIcon(Icons.person_sharp,color: Colores.crema,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('No se ha podido concretar su registro intente de nuevo')),
                    ],),
                    backgroundColor: Colores.rojo,
                      ),);
                  } 
              },
              child: Container(
                height: height * 0.1,
                width: 200,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colores.amarillo,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Text("Continuar",
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),

          AnimatedContainer( // RESPONSIVE NAVBAR EN MOBILES
            //NAVBAR---------------------
            margin: const EdgeInsets.only(top: 79.0),
            duration: const Duration(milliseconds: 375),
            curve: Curves.ease,
            height: (width < 800.0) ? collapsableHeight : 0.0,
            width: double.infinity,
            color: Colores.rojo,
            child: SingleChildScrollView(
              child: Column(
                children: navBarItems,
              ),
            ),
          ),
          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(color: Colores.rojo, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/circle logo.png')),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  if (width < 800.0) {
                    return NavBarButton(
                      onPressed: () {
                        if (collapsableHeight == 0.0) {
                          setState(() {
                            collapsableHeight = 240.0;
                          });
                        } else if (collapsableHeight == 240.0) {
                          setState(() {
                            collapsableHeight = 0.0;
                          });
                        }
                      },
                    );
                  } else {
                    return Row(
                      children: navBarItems,
                    );
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }



  Row dropDownExperiencia() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("Años de experiencia:   ",
        style: GoogleFonts.quicksand(
          fontSize: 14,
          fontWeight: FontWeight.w500)),
      Container(
        decoration: BoxDecoration(
           color: const Color.fromRGBO(53, 62, 123, 0.1),
           borderRadius: BorderRadius.circular(20)
         ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButton<String>(
            alignment: Alignment.center,
            borderRadius: BorderRadius.circular(25),
            focusColor: Colors.transparent,
            value: exp,
            icon: const Icon(Icons.arrow_downward_rounded),
            onChanged: (String? newValueExp){
              setState(() {
                exp = newValueExp!;
              });},
            items: <String>['menos de 1','1','2','3','4','5','6 o más']
                  .map<DropdownMenuItem<String>>((String valueExp) {
                return DropdownMenuItem<String>(
                  value: valueExp,
                  child: Text(valueExp),
                );
              }).toList(),
            ),
        ),
      ),
      ],
    );
  }

  Column dropDowntitle() {
    return Column(
      children: [
        Text("¿Qué actividad define mejor su trabajo?",
          style: GoogleFonts.quicksand(
            fontSize: 15,
            fontWeight: FontWeight.w500)),
        const Divider(),
        Container(
          decoration: BoxDecoration(
             color: const Color.fromRGBO(53, 62, 123, 0.1),
             borderRadius: BorderRadius.circular(20)
           ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(20),
              focusColor: Colors.transparent,
              value: categoria,
              icon: const Icon(Icons.arrow_downward_rounded),
              onChanged: (String? newValueCat){
                setState(() {
                  categoria = newValueCat!;
                });},
              items: <String>[ 'Agricultura', 'Adorno y Decoración', 'Carpintería', 
              'Cocina','Conducción', 'Construcción', 'Diseño Gráfico', 'Enfermería', 'Ilustración', 'Instalación electrica',
              'Limpieza', 'Música',
              'Plomería','Programación Movil',
              'Programación Web','Reparación de PC', 'Reparación de Celulares', 'Resguardo',
              'Sastrería', 'Vigilancia']
                    .map<DropdownMenuItem<String>>((String valueCat) {
                  return DropdownMenuItem<String>(
                    value: valueCat,
                    child: Text(valueCat,),
                  );
                }).toList(),
              ),
          ),
        ),
      ],
    );
  }

  String categoryToID({required String value }){
    var categories = {
      'Hogar' : '62582dacbfd25a4780637a82',
      'Salud' : '62582dc5bfd25a4780637a86',
      'Eventos': '62582ea3bfd25a4780637a97',
      'Negocio' : '625f198600e23222dc64956e',
      'Reparación' : '625f4b8c8d7dac368531aeaa',
      'Limpieza': '627f1b2db238a24871bf695c',
      'Agricultura': '627f1deeb238a24871bf6980',
      'Carpintería': '627f209ab238a24871bf698d',
      'Construcción': '627f1d64b238a24871bf6973',
      'Computadoras':'627f20f5b238a24871bf6999',
      'Seguridad' : '627f23c0b238a24871bf69c6',
      'Mascotas' : '627f22d2b238a24871bf69b9',
      'Arte' : '62582dd6bfd25a4780637a8a',
      'Diseño' : '627f20bbb238a24871bf6993'
    };
    
    String? id = categories.remove(value);
     
    return id ?? '//';
  }
  
  Column dropDownSkills() {
    return Column(
      children: [
        Text("Algunas otras actividades que realiza: ",
        style: GoogleFonts.quicksand(
          fontSize: 15,
          fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,),
          child: DropDownMultiSelect(
            onChanged: (List<String> x) {
              setState(() {
                skillsSelected = x;
              });
            }, 
            options: const [ 'Agricultura', 'Adorno y Decoración', 'Carpintería', 
              'Cocina','Conducción', 'Construcción', 'Diseño Gráfico', 'Enfermería', 'Ilustración', 'Instalación electrica',
              'Limpieza', 'Música',
              'Plomería','Programación Movil',
              'Programación Web','Reparación de PC', 'Reparación de Celulares', 'Resguardo',
              'Sastrería', 'Vigilancia'],
            selectedValues: skillsSelected, 
            whenEmpty: 'Seleccione almenos una',
            ),
        ),
      ],
    );
  }

  Column dropDownCategories() {

    return Column(
      children: [
        Text("Categorías en las que entra su servicio:",
        textAlign: TextAlign.justify,
        style: GoogleFonts.quicksand(
          fontSize: 13,
          fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,),
          child: DropDownMultiSelect(
            onChanged: (List<String> x) {
              setState(() {
                categoriasSelected = x;
              });
            }, 
            options: const ['Hogar','Salud','Eventos', 'Negocio', 'Reparación','Agricultura', 'Arte', 
            'Carpintería', 'Construcción', 'Computadoras', 'Diseño',  'Limpieza',
                'Seguridad', 'Mascotas'],
            selectedValues: categoriasSelected, 
            whenEmpty: 'Seleccione almenos una',
            ),
        ),
      ],
    );
  }
}

