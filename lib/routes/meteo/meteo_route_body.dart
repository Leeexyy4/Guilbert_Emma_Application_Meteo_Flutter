import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/common/db/db_helper.dart';
import 'package:guilbertemmaflutterproject/common/model/ville.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:guilbertemmaflutterproject/api/api.dart';


class MeteoRouteBody extends StatefulWidget {
  const MeteoRouteBody({super.key});

  @override
  State<MeteoRouteBody> createState() => _MeteoRouteBodyState();
}

class _MeteoRouteBodyState extends State<MeteoRouteBody> {
  Map<String, dynamic>? data;
  String? ville;
  String? meteo;
  double? temp;
  double? tempMin;
  double? tempMax;
  String? icon;
  String? image = 'https://openweathermap.org/img/wn/01d@2x.png';
  TextEditingController? villeController = TextEditingController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Appeler fetchData lors de l'initialisation de l'état
    fetchData();
    // Définir un Timer.periodic pour mettre à jour les données toutes les minutes
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      final villes = await DbHelper.readAllVilles(); // Récupérer toutes les villes
      int compteur = 0;
      for (final ville in villes) {
        Ville? villeajt = await DbHelper.readVille(
            ville.id!); // Assurez-vous que l'ID n'est pas null
        if (villeajt != null && compteur==0) {
          compteur += 1;
          setState(() {
            this.ville = villeajt.nom;
          });
        }
      }
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
            tempMin = data!['main']['temp_min'];
            tempMax = data!['main']['temp_max'];
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

  Color? backgroundColor() {
    try {
      int today = DateTime.now().hour;
      Color? background;
      if (today >= 0 && today <= 12){
        background = MyColors.beige;
      }
      else if (today > 12 && today <= 18){
        background = MyColors.green;
      }
      else if (today > 18 && today <= 23) {
        background = MyColors.blue;
      }
      return background;
    } catch (e) {
        throw Exception('Failed to load datetime');
      }
  }

  @override
  void dispose() {
    super.dispose();
    // Arrêter le Timer lors de la suppression du widget
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return Container(
        color: backgroundColor(),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            const SizedBox(height: 20),
            Text("Ma position\n$ville",style: const TextStyle(fontSize: 40, color: MyColors.purple), textAlign: TextAlign.center),
            Image.network(image!),
            Text("$meteo\n",style: const TextStyle(fontSize: 20, color: MyColors.purple), textAlign: TextAlign.center),
          Text("$temp°",style: const TextStyle(fontSize: 55, color: MyColors.purple), textAlign: TextAlign.center),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset("assets/img/interface_home/fleche_haut.png",width: 20, height: 20),
            Text("$tempMin°",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
            Image.asset('assets/img/interface_home/fleche_bas.png',width: 20, height: 20),
            Text("$tempMax°",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
          ]),
            const SizedBox(height: 20),
          //Text(data.toString()),
        ],
        ),
    );
  }

}
