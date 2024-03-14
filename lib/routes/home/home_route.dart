import 'package:guilbertemmaflutterproject/routes/home/home_route_body.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Appbar
      appBar: AppBar(
        title: const Text("IMC Calculator"),
      ),

      // Contenu de la page
      body: const HomeRouteBody(),
    );
  }
}
