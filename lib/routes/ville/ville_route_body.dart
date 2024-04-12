import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/common/model/ville.dart';
import 'package:guilbertemmaflutterproject/common/db/db_helper.dart';

class VilleRouteBody extends StatefulWidget {
  const VilleRouteBody({super.key});

  @override
  State<VilleRouteBody> createState() => _VilleRouteBodyState();
}

class _VilleRouteBodyState extends State<VilleRouteBody> {
  String? ville;
  TextEditingController? villeController = TextEditingController();
  List<Ville> villes = [];

  Future<void> ajoutVille() async {
    try {
      final addville = Ville(ville: ville!);
      villes.add(addville);
      await DbHelper.create(addville);

      print(DbHelper.readAllVilles());

    } catch (e) {
      throw Exception('Failed to add ville');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: villeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Entrer la ville souhaitée',
              ),
              onChanged: (value) {
                setState(() {
                  ville = value;
                });
              },
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.shortestSide - MediaQuery.of(context).padding.top,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(ville.toString())
                  ],
                ),
              ),
            ),
            FloatingActionButton.extended(
              onPressed: ajoutVille,
              label: const Text('Ajouter'),
              icon: const Icon(Icons.add_location_alt_outlined),
              foregroundColor: MyColors.purple,

            ),
          ]

      );
  }

}
