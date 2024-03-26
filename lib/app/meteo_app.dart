import 'package:flutter/material.dart';
import '../routes/accueil//accueil_route.dart';

class MeteoApp extends StatelessWidget {
  const MeteoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AccueilRoute(),
    );
  }
}
