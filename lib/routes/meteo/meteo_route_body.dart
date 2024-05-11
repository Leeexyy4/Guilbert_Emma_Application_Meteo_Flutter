import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
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
            tempMin = data!['main']['tempMin'];
            tempMax = data!['main']['tempMax'];
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
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return Container(
        color: backgroundColor(),
        child: Column(
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
        Image.network(image!),
        Text("Ma position\n$ville",style: const TextStyle(fontSize: 20, color: MyColors.purple), textAlign: TextAlign.center),
        Text("$temp°",style: const TextStyle(fontSize: 35, color: MyColors.purple), textAlign: TextAlign.center),
        Text("$meteo\n",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset("assets/img/interface_home/fleche_haut.png",width: 20, height: 20),
          Text("$tempMin°",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
          Image.asset('assets/img/interface_home/fleche_bas.png',width: 20, height: 20),
          Text("$tempMax°",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
        ]),
        ElevatedButton(
          onPressed: fetchData,
          child: const Text('Fetch Data'),
        ),
        const SizedBox(height: 20),
        Text(data.toString()),
      ],
        ),
    );
  }

}
