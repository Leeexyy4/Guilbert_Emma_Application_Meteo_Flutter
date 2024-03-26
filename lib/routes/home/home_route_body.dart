import 'package:flutter/material.dart';

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({super.key});

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  // Les variables du body

  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Uri.https('example.com', 'whatsit/create');

    ],
    );
  }
}
