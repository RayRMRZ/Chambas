import 'package:chambas/constants/colores.dart';
import 'package:chambas/helpers/JSON/helpers.dart';
import 'package:chambas/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../pages/pages.dart';

class PerfilSearchDelegate extends SearchDelegate{
  @override
  String get searchFieldLabel => 'Buscar nombre, categoria o actividad';

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton( 
     icon: const Icon(Icons.clear, color: Colores.rojo ,),
     onPressed: () => query = '')
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context,null), 
    icon: const Icon(Icons.arrow_back, color: Colores.rojo ,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   if(query.isEmpty){
     return const Center(child: Icon(Icons.art_track_outlined, 
                                color: Colores.rojo , size: 90,));
   }

    final freelanceProvider = Provider.of<FreelancerProvider>(context, listen: false);
    freelanceProvider.getSuggestionsByQuery(query);
   return StreamBuilder(
     stream: freelanceProvider.suggestionStream,
     builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot){
       final freelancers = snapshot.data;
       return (!snapshot.hasData)? const Center(
         child: CupertinoActivityIndicator(radius: 30,))
        :ListView.builder(
         itemCount: freelancers!.length,
         itemBuilder: (_, int index) => _FreelanceItem(freelancers[index]));
     });

  }

}

class _FreelanceItem extends StatelessWidget {
  final Result freelance;
  const _FreelanceItem(this.freelance);

  @override
  Widget build(BuildContext context) {
    final freelanceProvider = Provider.of<FreelancerProvider>(context, listen: false);
    return JelloIn(
      duration: const Duration(seconds: 1),
      child: ListTile(
        leading: Hero(
          tag: freelance.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: FadeInImage(placeholder: const AssetImage('assets/profile pic.png'),
            image: NetworkImage(freelance.ref.img),
            width: 50,
            height: 50,
            fit: BoxFit.cover,),
          ),
        ),
        title: Text(freelance.ref.name, 
                            style: GoogleFonts.quicksand(
                              color: Colores.rojo, 
                              fontWeight: FontWeight.w700),),
        subtitle: Text('${freelance.skills[0]}\n${freelance.skills[1]}', 
                            style: GoogleFonts.quicksand(
                              color: Colors.black, 
                              fontWeight: FontWeight.w400),),
        onTap: ()async{
          bool isInitialized = await freelanceProvider.getOnDisplayInfo(freelance.id);
            if(isInitialized){
            Navigator.of(context).pushNamed(FreeInfo.route,arguments: freelanceProvider.onlyFreelancer);
            }
        },
        isThreeLine: true,
        hoverColor: Colores.crema,
      ),
    );

  }
}