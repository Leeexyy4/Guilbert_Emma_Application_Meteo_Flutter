import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/api/api.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:http/http.dart' as http;

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({super.key});

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  // Les variables du body
  Map<String, dynamic>? data;
  String? ville;
  double? temp;
  String? icon;
  String? image = 'https://openweathermap.org/img/wn/01d@2x.png';
  TextEditingController? villeController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=${ApiData.apikey}&units=metric&lang=fr'));
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
        Text("Ma position\n$ville",style: const TextStyle(fontSize: 20, color: MyColors.purple), textAlign: TextAlign.center),
        Text("$temp°",style: const TextStyle(fontSize: 35, color: MyColors.purple), textAlign: TextAlign.center),
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
        Text(data.toString()),
      ],
    );
  }

}
