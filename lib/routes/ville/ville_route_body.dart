import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VilleRouteBody extends StatefulWidget {
  const VilleRouteBody({super.key});

  @override
  State<VilleRouteBody> createState() => _VilleRouteBodyState();
}

class _VilleRouteBodyState extends State<VilleRouteBody> {
  // Les variables du body
  Map<String, dynamic>? data;
  String? ville = '';
  double? temp = 0.0;
  String? icon = '';
  String? image = 'https://openweathermap.org/img/wn/01d@2x.png';
  TextEditingController? villeController = TextEditingController();

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
        Image.network(image!),
        const Text("Page Ville"),
        ElevatedButton(
          onPressed: fetchData,
          child: const Text('Fetch Data'),
        ),
        const SizedBox(height: 20),
        Text(data.toString()),

      ],
    );
  }

}
