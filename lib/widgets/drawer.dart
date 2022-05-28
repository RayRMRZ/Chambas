import 'package:flutter/material.dart';

import 'package:chambas/constants/colores.dart';

import 'package:provider/provider.dart';
import 'package:chambas/pages/pages.dart';
import 'package:chambas/widgets/perfil_image.dart';

import 'package:chambas/models/User.dart';
import 'package:chambas/models/Session.dart';


class DrawerSide extends StatelessWidget {
  User user;
  DrawerSide(this.user, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final session       = Provider.of<Session>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name), 
            accountEmail: Text(user.emailUsr),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: getImage(user.img)
              ),
                decoration: const BoxDecoration(color: Colores.azul, 
                image: DecorationImage(
                image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'), 
                fit: BoxFit.cover)),),
         ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoritos'),
            onTap: () {},
          ),
           ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Historial'),
            onTap: () {Navigator.of(context).pushNamed(HistorialPage.route);},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Salir'),
            onTap: () async{
              await session.logout();
              Navigator.pushNamed(context, Login.route);},
          ),
          
        ],
      ),
    );
  }
}