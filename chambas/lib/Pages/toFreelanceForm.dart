
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect/multiselect.dart';
import 'package:chambas/constants/colores.dart';
import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class ToFreelance extends StatefulWidget {
  
  static const String route = '/toFreelance'; //NECESARIO PARA LA NEAVEGACION

  const ToFreelance();
  @override
  _ToFreelanceState createState() => _ToFreelanceState();
}

class _ToFreelanceState extends State<ToFreelance> {
  
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  String exp = "menos de 1";
  String categoria = "Hogar";
  List<String> categoriasSelected = [];
  TextEditingController numeroTelController = TextEditingController();  

  final _formKey = GlobalKey<FormState>();
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

            // AQUI VA A IR LA IMAGEN DINAMICA DE DIFERENTES OFICIOS
          ),

          Center(     //SECCION BLANCA DE PÁGINA
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
                    offset: const Offset(0, 0), // changes position of shadow
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
                          key: _formKey,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            field('Vinculo/link de su Facebook', facebookController),
                            field('Vinculo/link de su Instagram', instagramController),
                            field('Vinculo/link de su Youtube', githubController),
                            field('Vinculo/link de su Github', youtubeController),
                            
                            dropDownExperiencia(),
                            const SizedBox(height: 10),
                            dropDownCategoria(),
                            const SizedBox(height: 30),
                            dropDownSkills(),
                            const SizedBox(height: 50),


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
          fontSize: 15,
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
            items: <String>['menos de 1','1 a 2','3 a 4','5 a 10','10 a 15','15 a 20','20 o más']
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

  Row dropDownCategoria() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("Categoría:   ",
        style: GoogleFonts.quicksand(
          fontSize: 15,
          fontWeight: FontWeight.w500)),
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
            items: <String>['Hogar','Salud','Artesanía','Eventos y fechas especiales','Negocio','Reparación']
                  .map<DropdownMenuItem<String>>((String valueCat) {
                return DropdownMenuItem<String>(
                  value: valueCat,
                  child: Text(valueCat),
                );
              }).toList(),
            ),
        ),
      ),
      ],
    );
  }

  
  Column dropDownSkills() {
    return Column(
      children: [
        Text("Algunas otras categorías en las que entra su servicio:",
        style: GoogleFonts.quicksand(
          fontSize: 15,
          fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,),
          child: DropDownMultiSelect(
            onChanged: (List<String> x) {
              setState(() {
                categoriasSelected = x;
              });
            }, 
            options: const ['Agricultura/Plantas', 'A Domicilio', 'Arte', 'Diseño Gráfico', 'Carpintería', 
            'Comida', 'Construccion', 'Electricidad', 'Finanzas', 'Plomería', 'Herreria', 'Hogar', 'Limpieza',
            'Mecánica', 'Negocio', 'Salud', 'Sastrería', 'Seguridad', 'Veterinaria/Mascotas'], 
            selectedValues: categoriasSelected, 
            whenEmpty: 'Seleccione almenos una',
            ),
        ),
      ],
    );
  }
}

