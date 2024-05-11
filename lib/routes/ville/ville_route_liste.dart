import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/common/model/ville.dart';
import 'package:guilbertemmaflutterproject/common/db/db_helper.dart';
import 'ville_route_body.dart';

class VilleRouteListe extends StatefulWidget {
  @override
  State<VilleRouteListe> createState() => _VilleRouteListeState();
}

class _VilleRouteListeState extends State<VilleRouteListe> {
  // Fonction pour appeler DbHelper.delete
  void onDeletePressed(int id) async {
    await DbHelper.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ville>>(
      future: DbHelper.readAllVilles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final villes = snapshot.data!;
          return ListView.builder(
            itemCount: villes.length,
            itemBuilder: (context, index) {
              final ville = villes[index];
              return ListTile(
                title: Text(ville.nom),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_backspace_outlined),
                  onPressed: () {
                    onDeletePressed(ville.id!);
                    setState(() {}); // Actualise la vue après la suppression
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
