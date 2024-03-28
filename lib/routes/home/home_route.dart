import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/routes/home/home_route_body.dart';

import '../meteo/meteo_route_body.dart';
import '../ville/ville_route_body.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);


  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  // Les variables du body
  int _selectedIndex = 0;
  Widget _bodyMenu = const HomeRouteBody();

  void _onItemTapped(int currentIndex) {
    try {
      setState(() {
        _selectedIndex = currentIndex;
        if (currentIndex == 0 ){
          _bodyMenu = const HomeRouteBody();
        }
        else if (currentIndex == 1 ){
          _bodyMenu = const MeteoRouteBody();
        }
        else if (currentIndex == 2 ){
          _bodyMenu = const VilleRouteBody();
        }
      });
    } catch (e) {
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text("Meteo - Emma Guilbert"),
          flexibleSpace: Image.asset("assets/img/logo/logosidebarapplimeteo.png", fit: BoxFit.cover)
      ),
      body:  Center(child: _bodyMenu),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_outlined),
            label: 'Météo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_outlined),
            label: 'Ville',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.green,
        onTap: _onItemTapped,
      ),
    );
  }

}
