import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/routes/home/home_route.dart';
import 'package:flutter/material.dart';

class AccueilRoute extends StatefulWidget {
  const AccueilRoute({super.key});

  @override
  State<AccueilRoute> createState() => _AccueilRouteState();
}

class _AccueilRouteState extends State<AccueilRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.blue,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset("assets/img/logo/logoapplimeteo.png"),

            ),
            ElevatedButton(onPressed: () {
              _goToHome(context);
            }, style: ElevatedButton.styleFrom(backgroundColor: MyColors.green, foregroundColor: MyColors.blue ), child: const Icon(Icons.play_arrow_outlined)),
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

  void _goToHome(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeRoute()),
    );
  }
}
