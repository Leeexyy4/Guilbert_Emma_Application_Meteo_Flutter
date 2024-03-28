import 'dart:convert';

import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/routes/home/home_route.dart';
import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/api/api.dart';
import 'package:http/http.dart' as http;

class AccueilRoute extends StatefulWidget {
  const AccueilRoute({super.key});

  @override
  State<AccueilRoute> createState() => _AccueilRouteState();
}

class _AccueilRouteState extends State<AccueilRoute> {
  Map<String, dynamic>? data;
  String? ville;
  String? meteo;
  double? temp;
  double? temp_min;
  double? temp_max;
  String? icon;
  String? image = 'https://openweathermap.org/img/wn/01d@2x.png';
  TextEditingController? villeController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=${ApiData
              .apikey}&units=metric&lang=fr'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          if (null != data) {
            icon = data!['weather'][0]['icon'];
            image = "https://openweathermap.org/img/wn/$icon@2x.png";
            temp = data!['main']['temp'];
            temp_min = data!['main']['temp_min'];
            temp_max = data!['main']['temp_max'];
            meteo = data!['weather'][0]['description'];
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

  // Getters pour rendre les variables accessibles depuis d'autres fichiers
  String? getVille() => ville;
  String? getMeteo() => meteo;
  double? getTemp() => temp;
  double? getTempMin() => temp_min;
  double? getTempMax() => temp_max;
  String? getIcon() => icon;
  String? getImage() => image;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.lightgreen,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset("assets/img/logo/logoapplimeteo.png"),

            ),
            ElevatedButton(onPressed: () {
              _goToHome(context);
              fetchData();
            }, style: ElevatedButton.styleFrom(backgroundColor: MyColors.blue, foregroundColor: MyColors.lightgreen ), child: const Icon(Icons.play_arrow_outlined,)),
    Container(
      margin: const EdgeInsets.all(20),
    width: 350,
    height: 150,
    alignment: Alignment.center,
    child: const Text("Création d'une application météo dans le cadre d'un projet Flutter", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: MyColors.purple) , textAlign: TextAlign.center))
          ],
        )
    );
  }

  void _goToHome(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeRoute()),
    );
  }
}
