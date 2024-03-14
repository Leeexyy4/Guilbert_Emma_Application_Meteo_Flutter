import 'package:projet/routes/home/home_route.dart';
import 'package:flutter/material.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: Image.asset("assets/img/insta.png"),
            ),
            ElevatedButton(onPressed: () => _goToHome(context), child: Icon(Icons.play_arrow))
          ],
        )
    );
  }

  void _goToHome(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeRoute()),
    );
  }
}
