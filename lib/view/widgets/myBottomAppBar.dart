import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 3,
        color: const Color(0xff011329), // Cor azul
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/homePage');
                },
                iconSize: 20,
                icon: const Icon(Icons.home),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                iconSize: 20,
                icon: const Icon(Icons.directions_car),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                iconSize: 20,
                icon: const Icon(Icons.key),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                iconSize: 20,
                icon: const Icon(Icons.dashboard),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
