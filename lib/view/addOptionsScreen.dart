import 'package:flutter/material.dart';
import 'package:ss_auto/view/widgets/listTileAddOptionsScreen.dart';

import 'widgets/myBottomAppBar.dart';
import 'widgets/myFloatingActionButton.dart';

class AddOptionsScreen extends StatelessWidget {
  const AddOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);
    return Scaffold(
      backgroundColor: blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTileAddOptionsScreen(
              onTap: () {
                Navigator.of(context).pushNamed('/vehicleRegistration');
              },
              title: 'ADICIONAR CARRO',
              color: orange,
              icon: Icons.directions_car),
          ListTileAddOptionsScreen(
              onTap: () {
                Navigator.of(context).pushNamed('/managerRegistration');
              },
              title: 'CADASTRAR GERENTE',
              color: orange,
              icon: Icons.supervisor_account),
          ListTileAddOptionsScreen(
              onTap: () {
                Navigator.of(context).pushNamed('/customerRegistration');
              },
              title: 'CADASTRAR CLIENTE',
              color: orange,
              icon: Icons.person_add_alt_1),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingActionButton(
        color: blue,
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
