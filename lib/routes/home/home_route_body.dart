import 'package:flutter/material.dart';

import '../../common/colors/mycolors.dart';

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({super.key});

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {

  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return Scaffold(
        backgroundColor: MyColors.blue,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset("assets/img/logo/logoapplimeteo.png"),

            ),
            Container(
                margin: const EdgeInsets.all(20),
                width: 350,
                height: 150,
                alignment: Alignment.center,
                child: const Text("Création d'une application météo dans le cadre d'un projet Flutter", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: MyColors.green) , textAlign: TextAlign.center))
          ],
        )
    );
  }

}
