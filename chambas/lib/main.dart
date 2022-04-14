// ignore_for_file: prefer_const_constructors

import 'package:chambas/Pages/login.dart';
import 'package:chambas/constants/colores.dart';
import 'package:flutter/material.dart';
import 'package:chambas/widgets/navBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/categorias.dart';
import 'Pages/register.dart';
import 'package:auto_size_text/auto_size_text.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      Register.route: (context) => Register(),
      Login.route: (context) => Login(),
      Categorias.route: (context) => Categorias(),
    },
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [
      InkWell(
        mouseCursor: SystemMouseCursors.move,
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorías',
        ),
      ),
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        onTap: () {
          Navigator.of(context).pushNamed(Login.route);
        },
        child: const NavBarItem(
          text: 'Ingresar',
        ),
      ),
      InkWell(
        mouseCursor: SystemMouseCursors.help,
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Register.route);
        },
        child: const NavBarItem(
          text: 'Registrarse',
        ),
      ),
    ];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.1),

            // AQUI VA A IR LA IMAGEN DINAMICA DE OFICIOS
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: 
                SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(
                      height: (width > 1050)? 300 :(width > 700.0)? 250 : 500,
                      child: GridView.count(
                        controller: ScrollController(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        padding: EdgeInsets.all(20),
                        childAspectRatio: (width > 1050)? 0.85 :(width > 700.0)? 0.5 : 0.7,
                        crossAxisCount: (width < 700.0) ? 3 : 6, //Cuantos elementos por fila
                        children: [
                          botonCircular('assets/artesania.png', 'Artesanías\n', '/'),
                          botonCircular('assets/casa.png', 'Para tu\nhogar', '/'),
                          botonCircular('assets/evento.png', 'Eventos y\nfechas especiales', '/'),
                          botonCircular('assets/herramienta.png', 'Reparación\n', '/'),
                          botonCircular('assets/saludable.png', 'Mi salud\n', '/'),
                          botonCircular('assets/tienda.png', 'Para mi\nnegocio', '/'),
                        ],
                      ),
                    ),
                    Text("      Profesionistas Destacados",
                            textAlign: TextAlign.left, 
                            style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: (width > 1050)? 300 :(width > 700.0)? 200 : 400,
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        padding: EdgeInsets.all(20),
                        childAspectRatio: (width < 700.0) ? 5 : 3,
                        crossAxisCount: (width < 700.0) ? 1 : 3, //Cuantos elementos por fila
                        children: [
                          tarjetaPerfil('assets/profile pic.png', 'Diseñador Gráfico', 'Raymundo Ramirez A.', 4, '/'),
                          tarjetaPerfil('assets/profile pic.png', 'Electrico', 'Azael Moreno R.', 2, '/'),
                          tarjetaPerfil('assets/profile pic.png', 'Veterinario', 'Gustavo Balderas R.', 5, '/'),
                        ],
                      ),
                    ),

                    Text("      Contratados Recientemente",
                            textAlign: TextAlign.left, 
                            style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: (width > 1050)?  300 :(width > 700.0)? 200 : 400,
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        padding: EdgeInsets.all(20),
                        childAspectRatio: (width < 700.0) ? 5 : 3,
                        crossAxisCount: (width < 700.0) ? 1 : 3, //Cuantos elementos por fila
                        children: [
                          tarjetaPerfil('assets/profile pic.png', 'Albañil', 'Pablo Mendoza B.', 3, '/'),
                          tarjetaPerfil('assets/profile pic.png', 'Plomero', 'Javier Martinez G.', 4, '/'),
                          tarjetaPerfil('assets/profile pic.png', 'Talachero', 'Gabriel Sanchez T.', 4, '/'),
                        ],
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
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset('assets/circle logo.png')),
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

  Material botonCircular(String imagen, String texto, String ruta) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        hoverColor: Color.fromRGBO(100, 100, 100, 0.08),
        onTap: () {
          Navigator.of(context).pushNamed(ruta);
        },
        child: Container(
          height: 100,
          width: 70,
          padding: EdgeInsets.symmetric(vertical: 20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                padding: EdgeInsets.all(20),
                child: Image.asset(imagen),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ]),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Text(texto,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      color: Colores.azul, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  tarjetaPerfil(String imagen, String profesion, String name, int stars, String ruta) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        hoverColor: Color.fromRGBO(100, 100, 100, 0.08),
        onTap: () {
          Navigator.of(context).pushNamed(ruta);
        },
        child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ]),
          child: Center(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric( horizontal: (width > 700.0)? 25 : 15, vertical: (width > 700.0)? 15 : 10 ),
                  child: Image.asset(imagen),
                ),
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Expanded(
                      child: AutoSizeText(profesion,
                      minFontSize: 5,
                      maxFontSize: 15,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.quicksand(
                          color: Colors.black, 
                          fontWeight: FontWeight.w900)),
                    ),
                    Expanded(
                      child: AutoSizeText(name,
                      minFontSize: 5,
                      maxFontSize: 15,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.quicksand(
                          color: Colors.black, 
                          fontWeight: FontWeight.w300)),
                    ),
                    
                    Expanded(
                      child: AutoSizeText("🟊"*stars,
                      minFontSize: 15,
                      maxFontSize: 20,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.notoSansSymbols2(
                          fontSize: 20,
                          color: Colores.amarillo, 
                          fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
