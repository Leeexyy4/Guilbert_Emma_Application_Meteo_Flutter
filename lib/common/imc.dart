import 'package:flutter/material.dart';

class IMC extends StatelessWidget {
  final double taillecm;
  final double poids;

  const IMC(this.poids, this.taillecm, {super.key});

  @override
  Widget build(BuildContext context) {

    final double imc = poids / ((taillecm/100) * (taillecm/100));

    return Text(imc.toStringAsFixed(1), style: const TextStyle(
        fontSize: 32
      ),
    );
  }
}
