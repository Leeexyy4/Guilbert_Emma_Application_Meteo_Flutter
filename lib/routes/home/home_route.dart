import 'package:guilbertemmaflutterproject/routes/home/home_route_body.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Appbar
      appBar: AppBar(
        title: const Text("Application Météo - Emma Guilbert"),
        flexibleSpace: Image.asset("assets/img/logosidebarapplimeteo.png", fit: BoxFit.cover,),
      ),

      // Contenu de la page
      body: const Center(child: HomeRouteBody()),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home', backgroundColor: Colors.pink,

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_outlined),
              label: 'Météo', backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_work_outlined),
              label: 'Ville',backgroundColor: Colors.purple,

            ),
          ],
        )
    );
  }
}
