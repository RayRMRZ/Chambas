import 'package:animate_do/animate_do.dart';
import 'package:chambas/helpers/history.dart';
import 'package:chambas/pages/pages.dart';
import 'package:chambas/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colores.dart';

class HistorialPage extends StatefulWidget {
  static const String route = '/historial';
  const HistorialPage({Key? key}) : super(key: key);

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  @override
  Widget build(BuildContext context) {
    Historial historial = Historial();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colores.rojo,),
      body: (historial.usuarios.isEmpty) ? 
      const Center(child: FaIcon(FontAwesomeIcons.addressBook, color: Colores.rojo, size: 50,)):
         ListView.builder(
            itemCount: historial.usuarios.length,
            itemBuilder: (BuildContext context, int index) {
              if(historial.usuarios.isEmpty){
                return const Center(child: Icon(Icons.art_track_outlined, 
                                color: Colores.rojo , size: 90,));
              }
              return _HistoryFreeitem(historial.usuarios[index]);
            },
          ),
        );
  }
}
class _HistoryFreeitem extends StatelessWidget {
  final Map<String,String> freelance;
  const _HistoryFreeitem(this.freelance);

  @override
  Widget build(BuildContext context) {
    final freelanceProvider = Provider.of<FreelancerProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(height: 20,),
        JelloIn(
          duration: const Duration(seconds: 1),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: FadeInImage(placeholder: const AssetImage('assets/profile pic.png'),
              image: NetworkImage(freelance['img'] ?? ""),
              width: 50,
              height: 50,
              fit: BoxFit.cover,),
            ),
            title: Text(freelance['name'] ?? "", 
                                style: GoogleFonts.quicksand(
                                  color: Colores.rojo, 
                                  fontWeight: FontWeight.w700),),
            onTap: ()async{
              bool isInitialized = await freelanceProvider.getOnDisplayInfo(freelance['id'] ?? "");
                if(isInitialized){
                Navigator.of(context).pushNamed(FreeInfo.route,arguments: freelanceProvider.onlyFreelancer);
                }
            },
            hoverColor: Colores.crema,
          ),
        ),
        const Divider(),
      ],
    );

  }
}