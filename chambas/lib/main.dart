// ignore_for_file: prefer_const_constructors
import 'package:chambas/Pages/ProfileEdit.dart';
import 'package:chambas/Pages/UserProfile.dart';
import 'package:chambas/models/sesion.dart';

import 'package:chambas/services/notifications.dart';
import 'package:chambas/widgets/popular_slider.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chambas/constants/colores.dart';

import 'package:chambas/pages/pages.dart';
import 'package:chambas/providers/providers.dart';
import 'package:chambas/widgets/widgets.dart';

void main() {
  runApp(AppState());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: 'check',
    routes: {
      'home' :(context) => MyHomePage(),
      Register.route: (context) => Register(),
      Login.route: (context) => Login(),
      Categorias.route: (context) => Categorias(),
      UserProfile.route: (context) => UserProfile(),
      ProfileEdit.route: (context) => ProfileEdit(),
      FreeInfo.route: (context)=> FreeInfo(),
      'check':(context) => CheckScreen(),

    },
    scaffoldMessengerKey: NotificationService.msgKey,
    home: MyHomePage(),
    theme: ThemeData.light().copyWith(),
    debugShowCheckedModeBanner: false,
  );
  }
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=> LoginProvider(), lazy: false, ),
      ChangeNotifierProvider(create: (_)=> CategoryProvider(), lazy: false, ),
      ChangeNotifierProvider(create: (_)=> Session(), lazy: false, ),
      ChangeNotifierProvider(create: (_)=> FreelancerProvider(), lazy: false, ),
      ],
      child: MyApp(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    
  @override
  Widget build(BuildContext context) {
    final catprovider = Provider.of<CategoryProvider>(context);
    final freeprovider = Provider.of<FreelancerProvider>(context);
    final session = Provider.of<Session>(context);

    List<Widget> navBarItems = [
      InkWell(
        splashColor: Colors.white60,
        onTap: () {
          Navigator.of(context).pushNamed(Categorias.route);
        },
        child: const NavBarItem(
          text: 'Categorías',
        ),
      ),

      if(true) InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Login.route);
        },
        child: const NavBarItem(
          text: 'Ingresar',),
      ),



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
        onTap: () {
          Navigator.of(context).pushNamed(UserProfile.route);
        },
        child: const NavBarItem(
          text: 'Perfil',),
      ),

      IconButton(onPressed: () async{
        await session.logout();
        Navigator.pushNamed(context, Login.route);
      }, icon: Icon(Icons.logout,color: Colores.crema,),)
    ];

    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.1),
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
                    CategorySlider(width,categories: catprovider.onDisplayCategory),
                    Divider( height: 20,),
                    PopularFrelancers(width, popular: freeprovider.onDisplayFreelancer),
                    Divider( height: 20,),
                    
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
                        children: [],
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
}
