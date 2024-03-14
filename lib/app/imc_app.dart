import 'package:projet/routes/home/home_route.dart';
import 'package:projet/routes/menu/menu_route.dart';
import 'package:flutter/material.dart';

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator', /* Titre de la page en-dessous de l'icone*/
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.amberAccent
        )
      ), /* Theme de la page */
      home: const MenuRoute(),
    );
  }
}
