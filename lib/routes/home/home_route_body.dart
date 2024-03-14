import 'dart:math';

import 'package:projet/common/imc.dart';
import 'package:projet/common/square.dart';
import 'package:projet/common/taille.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/poids.dart';

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({super.key});

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  double poidsKg = 3.0;
  double tailleCm = 50.0;

  bool initialized = false;
  bool hasChanged = false;
  bool radius = false;

  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      var poidsKg = prefs.getDouble('poids');
      var tailleCm = prefs.getDouble('taille');
      var radius = prefs.getBool('radius');

      if (!initialized) {
        setState(() {
          this.poidsKg = poidsKg ?? 3.0;
          this.tailleCm = tailleCm ?? 50.0;
          this.radius = radius ?? true;
          initialized = true;
        });
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Row(
            children: [
              RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                      value: tailleCm,
                      onChanged: onChangedTaille,
                      min: 50,
                      max: 230)),
              Expanded(
                child: Center(
                    child: Square(calculateColor(),
                        height: calculHeight(), width: calculWidth(), radius: radius)),
              )
            ],
          ),
        ),
        Slider(value: poidsKg, onChanged: onChangedPoids, min: 3, max: 200),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Taille(taille: tailleCm),
              Poids(poids: poidsKg),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        IMC(poidsKg, tailleCm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Radius ? "),
            Checkbox(value: radius, onChanged: onRadiusChanged)
          ],
        ),
        ElevatedButton(
            onPressed: hasChanged ? onSave : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ))
      ],
    );
  }

  void onRadiusChanged(bool? value){
    setState(() {
      if (radius == true) {
        radius = false;
      }
      else {
        radius = true;
      }

      hasChanged = true;

    });
  }

  void onChangedPoids(double value) {
    setState(() {
      poidsKg = value;
      hasChanged = true;
    });
  }

  void onChangedTaille(double value) {
    setState(() {
      tailleCm = value;
      hasChanged = true;
    });
  }

  double calculWidth() {
    return _calc(context, poidsKg, 3, 200);
  }

  double calculHeight() {
    return _calc(context, tailleCm, 50, 230);
  }

  /// Retourne la largeur du carré en fonction de :
  /// - la largeur de l'écran
  /// - la valeur passée en paramètre
  /// - la valeur minimale
  /// - la valeur maximale
  double _calc(BuildContext context, double value, double min, double max) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double ratio = (value - min) / (max - min);
    final double percent = (45.0 * ratio) + 5.0;
    return screenWidth * (percent / 100.0);
  }

  Color calculateColor() {
    final num taille2 = pow(tailleCm / 100.0, 2);
    final double imc = poidsKg / taille2;

    if (imc < 18.5) {
      return Colors.blueAccent;
    } else if (imc < 24.9) {
      return Colors.greenAccent;
    } else if (imc < 29.9) {
      return Colors.yellow;
    } else if (imc < 34.9) {
      return Colors.orange;
    } else if (imc < 39.9) {
      return Colors.deepOrange;
    } else {
      return Colors.black;
    }
  }

  void onSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('poids', poidsKg);
    prefs.setDouble('taille', tailleCm);
    prefs.setBool('radius', radius);
    setState(() {
      hasChanged = false;
    });
  }
}
