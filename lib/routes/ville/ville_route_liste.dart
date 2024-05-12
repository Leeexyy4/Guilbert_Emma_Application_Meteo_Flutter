import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:guilbertemmaflutterproject/common/model/ville.dart';
import 'package:guilbertemmaflutterproject/common/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';

class VilleRouteListe extends StatefulWidget {
  const VilleRouteListe({super.key});

  @override
  State<VilleRouteListe> createState() => _VilleRouteListeState();
}

class _VilleRouteListeState extends State<VilleRouteListe> {
  final TextEditingController _villeController = TextEditingController();
  String? ville;
  late SharedPreferences prefs; // Déclaration de prefs

  @override
  void initState() {
    super.initState();
    loadSharedPreferences(); // Chargement de SharedPreferences
  }

  Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {}); // Mettre à jour l'état après le chargement de prefs
  }

  Future<void> ajoutVille(String? ville) async {
    try {
      if (ville != null) {
        final response = await http.get(Uri.parse(
            'http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=${ApiData.apikey}&units=metric&lang=fr'));
        if (response.statusCode == 200) {
          if (await DbHelper.isVillePresent(ville) == false) {
            final addville = Ville(nom: ville);
            await DbHelper.create(addville);
            setState(() {}); // Mettre à jour l'état après l'ajout
          }
        } else {
          throw Exception('Failed to add ville');
        }
      }
    } catch (e) {
      debugPrint('Failed to add ville : $e');
    }
  }

  Future<void> onDeletePressed(int id) async {
    await DbHelper.delete(id);
    setState(() {}); // Mettre à jour l'état après la suppression
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ville>>(
      future: DbHelper.readAllVilles(),
      builder: (context, AsyncSnapshot<List<Ville>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final villes = snapshot.data!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _villeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Entrer la ville souhaitée',
              ),
              onEditingComplete: () async {
                setState(() {
                  ville = _villeController.value.text;
                });
                await ajoutVille(ville!);
              },
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  ville = _villeController.value.text;
                });
                await ajoutVille(ville!);
              },
              child: const Text('Ajouter'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: villes.length,
                itemBuilder: (context, index) {
                  final ville = villes[index];
                  return ListTile(
                    title: Text(ville.nom),
                    leading: const Icon(Icons.home_outlined),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.star_outline_sharp),
                          onPressed: () async {
                            final favCityId = prefs.getInt('favCityId');

                            if (favCityId == ville.id) {
                              await prefs.remove('favCityId');
                            } else {
                                await prefs.setInt('favCityId', ville.id!);
                            }
                            setState(() {});
                          },
                          color: prefs.getInt('favCityId') == ville.id
                              ? Colors.yellow
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await onDeletePressed(ville.id!);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _villeController.dispose();
    super.dispose();
  }
}
