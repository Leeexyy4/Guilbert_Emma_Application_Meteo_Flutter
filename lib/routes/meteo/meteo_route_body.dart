import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/common/db/db_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:guilbertemmaflutterproject/api/api.dart';

import '../../common/model/ville.dart';

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
  late SharedPreferences prefs; // Déclaration de prefs

  static const _backgroundColor = MyColors.rose;
  static const _colors = [MyColors.green, MyColors.purple];
  static const _durations = [5000, 4000];
  static const _heightPercentages = [0.60, 0.70];

  @override
  void initState() {
    super.initState();
    // Appeler loadSharedPreferences pour initialiser prefs
    loadSharedPreferences();
    fetchData();
    // Définir un Timer.periodic pour mettre à jour les données toutes les minutes
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchData();
    });
  }

  Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {}); // Mettre à jour l'état après le chargement de prefs
  }

  Future<void> fetchData() async {
    try {
      int compteur = prefs.getInt('favCityId')!;
      Ville? villeData = await DbHelper.readVille(compteur);
      if (villeData != null) {
        setState(() {
          ville = villeData.nom;
        });
      }
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=${ApiData.apikey}&units=metric&lang=fr'));
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
      if (today >= 0 && today <= 12) {
        background = MyColors.rose;
      } else if (today > 12 && today <= 18) {
        background = MyColors.green;
      } else if (today > 18 && today <= 23) {
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
          Text("Ma position\n$ville",
              style: const TextStyle(fontSize: 40, color: MyColors.purple),
              textAlign: TextAlign.center),
          Image.network(image!),
          Text("$meteo\n",
              style: const TextStyle(fontSize: 20, color: MyColors.purple),
              textAlign: TextAlign.center),
          Text("$temp°",
              style: const TextStyle(fontSize: 55, color: MyColors.purple),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset("assets/img/interface_home/fleche_haut.png",
                width: 20, height: 20),
            Text("$tempMin°",
                style: const TextStyle(fontSize: 15, color: MyColors.purple),
                textAlign: TextAlign.center),
            Image.asset('assets/img/interface_home/fleche_bas.png',
                width: 20, height: 20),
            Text("$tempMax°",
                style: const TextStyle(fontSize: 15, color: MyColors.purple),
                textAlign: TextAlign.center),
          ]),
          const SizedBox(height: 50),
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: _backgroundColor,
            size: const Size(415.0, 250.0),
            waveAmplitude: 0,
          ),
          //Text(data.toString()),
        ],
      ),
    );
  }
}
