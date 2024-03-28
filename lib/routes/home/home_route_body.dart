import 'package:flutter/material.dart';
import 'package:guilbertemmaflutterproject/common/colors/mycolors.dart';
import 'package:guilbertemmaflutterproject/routes/home/home_route.dart';

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({super.key});

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  @override
  Widget build(BuildContext context) {
    // Initialisation des valeurs from SharedPreferences
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(image!),
        Text("Ma position\n$ville",style: const TextStyle(fontSize: 20, color: MyColors.purple), textAlign: TextAlign.center),
        Text("$temp°",style: const TextStyle(fontSize: 35, color: MyColors.purple), textAlign: TextAlign.center),
        Text("$meteo\n",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset("assets/img/interface_home/fleche_haut.png",width: 20, height: 20),
          Text("$temp_min°",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
          Image.asset('assets/img/interface_home/fleche_bas.png',width: 20, height: 20),
          Text("$temp_max°",style: const TextStyle(fontSize: 15, color: MyColors.purple), textAlign: TextAlign.center),
        ]),
        TextField(
          controller: villeController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Entrer la ville souhaitée',
            ),
          onChanged: (value) {
          setState(() {
            ville = value;
            });
          },
        ),
        ElevatedButton(
          onPressed: fetchData,
          child: const Text('Fetch Data'),
        ),
        const SizedBox(height: 20),
        Text(data.toString()),
      ],
    );
  }

}
