import 'package:flutter/material.dart';

class Taille extends StatelessWidget {
  final double taille;

  const Taille({super.key, this.taille=150});

  @override
  Widget build(BuildContext context) {
    return Text("Taille : ${taille.toStringAsFixed(0)} cm", style: const TextStyle(
        fontSize: 20
      ),
    );
  }
}
