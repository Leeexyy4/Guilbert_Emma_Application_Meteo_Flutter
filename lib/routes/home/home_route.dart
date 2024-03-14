
import 'package:flutter/material.dart';
import 'package:projet/routes/home/home_route_body.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Appbar
      appBar: AppBar(
        title: const Text("Bienvenue sur mon application"),
      ),

      // Contenu de la page
      body: const HomeRouteBody(),
    );
  }
}
