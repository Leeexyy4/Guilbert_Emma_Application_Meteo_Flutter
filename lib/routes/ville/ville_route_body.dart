import 'package:flutter/material.dart';
import 'ville_route_liste.dart'; // Importez le widget VilleRouteListe

class VilleRouteBody extends StatefulWidget {
  const VilleRouteBody({super.key});

  @override
  State<VilleRouteBody> createState() => _VilleRouteBodyState();
}

class _VilleRouteBodyState extends State<VilleRouteBody> {

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: VilleRouteListe()
              ),
            ),
          ),
        ),
      ],
    );
  }
}
