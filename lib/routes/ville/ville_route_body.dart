import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:guilbertemmaflutterproject/common/model/ville.dart';
import 'package:guilbertemmaflutterproject/common/db/db_helper.dart';
import '../../api/api.dart';
import 'ville_route_liste.dart'; // Importez le widget VilleListWidget

class VilleRouteBody extends StatefulWidget {
  const VilleRouteBody({super.key});

  @override
  State<VilleRouteBody> createState() => _VilleRouteBodyState();
}

class _VilleRouteBodyState extends State<VilleRouteBody> {
  String? ville;
  TextEditingController? villeController;

  @override
  void initState() {
    super.initState();
    villeController = TextEditingController();
  }

  @override
  void dispose() {
    villeController?.dispose();
    super.dispose();
  }

  Future<void> ajoutVille() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=${ApiData.apikey}&units=metric&lang=fr'));
      if (response.statusCode == 200) {
        if (await DbHelper.isVillePresent(ville!) == false){
          final addville = Ville(nom: ville!);
          await DbHelper.create(addville);
        }
      } else {
        throw Exception('Failed to add ville');
      }
    } catch (e) {
      throw Exception('Failed to add ville');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: ajoutVille,
          child: const Text('Ajouter'),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: VilleRouteListe(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
