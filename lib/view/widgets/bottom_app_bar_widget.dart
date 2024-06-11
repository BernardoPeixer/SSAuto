import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({super.key});

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
                  Navigator.of(context).pushReplacementNamed('/homePage');
                },
                iconSize: 20,
                icon: const Icon(Icons.home),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                iconSize: 20,
                icon: const Icon(Icons.monetization_on),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/fleetPage');
                },
                iconSize: 20,
                icon: const Icon(Icons.directions_car),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/managerCustomerPage');
                },
                iconSize: 20,
                icon: const Icon(Icons.supervised_user_circle),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
