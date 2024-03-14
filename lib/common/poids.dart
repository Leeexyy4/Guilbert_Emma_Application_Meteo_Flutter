import 'package:flutter/material.dart';

class Poids extends StatelessWidget {
  final double poids;

  const Poids({super.key, this.poids=80});

  @override
  Widget build(BuildContext context) {
    return Text("Poids : ${poids.toStringAsFixed(1)} kg", style: const TextStyle(
      fontSize: 20
    ),);
  }
}
