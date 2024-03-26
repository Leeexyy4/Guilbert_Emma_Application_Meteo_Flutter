import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({super.key});

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  // Les variables du body
  Map<String, dynamic>? data;
  String ville = '';
  double temp = 0.0;
  String icon = '';
  String image = '';
  TextEditingController villeController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=bc16736a58f4db063a654f1dbeb84df7&units=metric'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          if(null != data){
              icon = data!['weather'][0]['icon'];
              image = "https://openweathermap.org/img/wn/$icon@2x.png";
              temp = data!['main']['temp'];
              print("$temp");
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        data = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        ElevatedButton(
          onPressed: fetchData,
          child: const Text('Fetch Data'),
        ),
        const SizedBox(height: 20),
        Image.network(image),
        Text(data.toString()),
        Text("La ville choisie est : $ville"),
        Text("L'icon de l'image est : $icon" ),
        Text("La température de la ville est : $temp" ),
      ],
    );
  }

}
