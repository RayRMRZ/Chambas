import 'package:flutter/material.dart';

import 'package:chambas/constants/colores.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class Categorias extends StatefulWidget {
  static const String route = '/categorias'; //NECESARIO PARA LA NEAVEGACION

  // ignore: use_key_in_widget_constructors
  const Categorias();
  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [
      InkWell(
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Register.route);
        },
        child: const NavBarItem(
          text: 'Registrarse',
        ),
      ),
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Login.route);
        },
        child: const NavBarItem(
          text: 'Ingresar',
        ),
      ),
    ];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colores.amarillo,

            // AQUI VA A IR LA IMAGEN DINAMICA DE OFICIOS
          ),
          Center(
            //SECCION BLANCA DE PÁGINA
            child: Container(
              //BODY------------------------------
              margin: const EdgeInsets.only(top: 120, bottom: 40),
              width: width < 700.0 ? width * 0.9 : width * 0.9,
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
                    padding: const EdgeInsets.only(top: 25, bottom: 30),
                    child: Text("Categorías",
                        style: GoogleFonts.quicksand(
                            color: Colores.azul,
                            fontSize: 30,
                            fontWeight: FontWeight.w700)),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * .7,
                      alignment: Alignment.topCenter,
                      child: GridView.count(
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        padding: const EdgeInsets.all(20),
                        controller: ScrollController(),
                          childAspectRatio: 1.5,
                          crossAxisCount: (width < 700.0) ? 2 : 4, //Cuantos elementos por fila
                          children: [
                            botonCategoria(Icons.grass , "Agricultura \ny Plantas", '/'),
                            botonCategoria(Icons.moped , "A Domicilio", '/'),
                            botonCategoria(Icons.palette , "Arte \ny Artesanías", '/'),
                            botonCategoria(Icons.adobe , "Diseño Gráfico", '/'),
                            botonCategoria(Icons.hardware, "Carpintería", '/'),
                            botonCategoria(Icons.flatware , "Cocina \ny comida", '/'),
                            botonCategoria(Icons.build , "Construcción", '/'),
                            botonCategoria(Icons.bolt, "Electricidad", '/'),
                            botonCategoria(Icons.account_balance_wallet , "Finanzas \ny Dinero", '/'),
                            botonCategoria(Icons.handyman , "Fontanería \ny Plomería", '/'),
                            botonCategoria(Icons.anchor, "Herrería", '/'),
                            botonCategoria(Icons.house , "Hogar", '/'),
                            botonCategoria(Icons.cleaning_services , "Limpieza", '/'),
                            botonCategoria(Icons.car_repair , "Mecánica", '/'),
                            botonCategoria(Icons.business , "Negocio", '/'),
                            botonCategoria(Icons.health_and_safety , "Salud", '/'),
                            botonCategoria(Icons.dry_cleaning , "Sastrería", '/'),
                            botonCategoria(Icons.security , "Seguridad", '/'),
                            botonCategoria(Icons.pets , "Veterinaria \ny Mascotas", '/'),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            //NAVBAR---------------------
            margin: const EdgeInsets.only(top: 79.0),
            duration: const Duration(milliseconds: 375),
            curve: Curves.ease,
            height: (width < 800.0) ? collapsableHeight : 0.0,
            width: double.infinity,
            color: Colores.amarillo,
            child: SingleChildScrollView(
              child: Column(
                children: navBarItems,
              ),
            ),
          ),
          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(color: Colores.amarillo, boxShadow: [
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

  Material botonCategoria(IconData icono, String texto, String ruta) {
    return Material(
      color: Colors.transparent,
      child: InkWell(

          borderRadius: BorderRadius.circular(30),
          hoverColor: const Color.fromRGBO(100, 100, 100, 0.1),
          onTap: () {
            Navigator.of(context).pushNamed(ruta);
          },
          child: Container(
            height: 10,
            width: 250,
            //margin: EdgeInsets.symmetric(horizontal: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(100, 100, 100, 0.1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icono,
                  size: 40,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(texto,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                          color: Colores.azul,
                          fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
    );
  }
}
