import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:chambas/constants/colores.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';
import 'package:chambas/services/dataService.dart';

import 'package:provider/provider.dart';
import 'package:chambas/providers/providers.dart';

import 'package:chambas/models/User.dart';

// ignore: use_key_in_widget_constructors
class ProfileEdit extends StatefulWidget {
  static const String route = '/editar'; //NECESARIO PARA LA NEAVEGACION

  // ignore: use_key_in_widget_constructors
  const ProfileEdit();
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isPerfil = true;


  TextEditingController whatsController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();

  TextEditingController instagramController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final infoForm = Provider.of<LoginProvider>(context);
    final User user = Provider.of<User>(context);
    List<Widget> navBarItems = [
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorias',
        ),
      ),
      
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(UserProfile.route);
        },
        child: const NavBarItem(
          text: 'Perfil',
        ),
      ),
    ];
    
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer:  DrawerSide(user),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
             color: Colors.grey.withOpacity(0.1),
               alignment: Alignment.bottomCenter,
               child: Padding(
                 padding: const EdgeInsets.only(top: 78),
                 child: SingleChildScrollView(
                   
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch, 
                     children: [
                       Positioned(
                         top: 50,
                         child: Text( 'Ajustes', textAlign: TextAlign.center,
                                       style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 40, 
                                          fontWeight: FontWeight.w400)),
                       ),
                       
                        Row(
                         children: [
                           
                           const SizedBox(width: 20,),
                           Text( 'Mi perfil',
                                 style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 20, 
                                    fontWeight: FontWeight.w200)),
                                    Expanded(child: Container()),
                         ],
                       ),
                      const Divider(),

                       Form(
                         child: Column(
                           children: [
                             field('Dirección', addressController),
                             field('Correo Electronico', emailController),
                             passwordField('Nueva contraseña', passwordController, infoForm),
                             field('Número telefono', phoneController),
                             Row(
                       children: [
                         
                         const SizedBox(width: 20,),
                         Text( 'Freelance',
                               style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontSize: 20, 
                                  fontWeight: FontWeight.w200)),
                                  Expanded(child: Container()),
                        CupertinoSwitch(value: isPerfil, activeColor: Colores.amarillo,onChanged: (value)
                        {
                          setState(() {
                            isPerfil = value;
                          });
                        })
                       ],
                       ),
                      const Divider(),

                      Visibility(
                        visible: !isPerfil,
                        child: const SizedBox(height: 70,))
                      ],
                         ),
                      ),

                     (user.role == 'FREE_ROLE')  ? Visibility(
                       visible: isPerfil,
                       child: _SocialForm(
                        whats: whatsController, 
                        facebook: facebookController, 
                        linkedin: linkedinController, 
                        youtube: youtubeController,
                        instagram: instagramController ),
                     ) : Container(),
                       
                     ]
                   ),
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
              color: Colores.azul,
              child: SingleChildScrollView(
                child: Column(
                  children: navBarItems,
                ),
              ),
            ),
            Container(
              height: 80.0,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(color: Colores.azul, boxShadow: [
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
        floatingActionButton: FloatingActionButton.small(
        backgroundColor:  Colores.azul,  
        child: const Icon(Icons.save),
        onPressed: (){
        Map<String,String> media = {}; Map<String,String> usuario = {};
          if(addressController.text.isNotEmpty){
            usuario.addAll({'address' : addressController.text});
          }
          if(emailController.text.isNotEmpty){
            usuario.addAll({'email' : emailController.text});
          }
          if(passwordController.text.isNotEmpty){
            usuario.addAll({'password' : passwordController.text});
          }
          if(phoneController.text.isNotEmpty){
            usuario.addAll({'phone' : phoneController.text});
          }

          if(facebookController.text.isNotEmpty){
            media.addAll({'facebook' : facebookController.text});
          }
          if(whatsController.text.isNotEmpty){
            media.addAll({'whatsapp' : whatsController.text});
          }
          if(linkedinController.text.isNotEmpty){
            media.addAll({'instagram' : linkedinController.text});
          }
          if(youtubeController.text.isNotEmpty){
            media.addAll({'youtube' : youtubeController.text});
          }
          if(instagramController.text.isNotEmpty){
            media.addAll({'linkedin' : instagramController.text});
          }
        DataService api = DataService();

        api.updateInfo(media, usuario);
        },),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      )
    );

  }
}

class _SocialForm extends StatelessWidget {
  TextEditingController whats;

  TextEditingController facebook;

  TextEditingController linkedin;

  TextEditingController youtube;

  TextEditingController instagram;

   _SocialForm({required this.whats,required this.facebook,required this.linkedin,required this.youtube,required this.instagram,});

  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      children: [
        field('Whatsapp (+52):', whats),
        field('Facebook', facebook),
        field('Linkedin', linkedin),
                            
        field('Youtube', youtube),
        field('Instagram', instagram),
        const SizedBox(height: 70,)
      ],
    ),);
  }
}