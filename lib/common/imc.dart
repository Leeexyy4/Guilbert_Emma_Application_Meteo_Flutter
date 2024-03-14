import 'package:flutter/material.dart';

class IMC extends StatelessWidget {
  final double taillecm;
  final double poidskg;

  const IMC(this.poidskg, this.taillecm, {super.key});

  @override
  Widget build(BuildContext context) {

    final double imc = poidskg / ((taillecm/100) * (taillecm/100));

    return Text(imc.toStringAsFixed(1), style: const TextStyle(
        fontSize: 32
      ),
    );
  }
}
