import 'dart:math';

import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final Color couleur;
  final double width;
  final double height;
  final bool radius;

  const Square(this.couleur, {super.key, this.width = 128, this.height = 128, this.radius = true});

  /*
  * Null safety autorise/n'autorise pas l'objet null
  * évite d'avoir des NullPointerException à la compilation
  */
  @override
  Widget build(BuildContext context) {

    double r = 0;
    if(radius){
      r = 0.2 * max(width, height ?? 128);
    }


    return AnimatedContainer(
      width: width,
      height: height,
      curve: Curves.elasticInOut,
      decoration: BoxDecoration(
        color: couleur,
        borderRadius: BorderRadius.circular(r)
      ), duration : Duration(milliseconds : 750),
    );
  }
}
