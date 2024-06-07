import 'package:flutter/material.dart';
import 'package:ss_auto/view/widgets/list_tile_add_options_widget.dart';

import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

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
          ListTileAddOptionsWidget(
              onTap: () {
                Navigator.of(context).pushNamed('/vehicleRegistration');
              },
              title: 'ADICIONAR CARRO',
              color: orange,
              icon: Icons.directions_car),
          ListTileAddOptionsWidget(
              onTap: () {
                Navigator.of(context).pushNamed('/managerRegistration');
              },
              title: 'CADASTRAR GERENTE',
              color: orange,
              icon: Icons.supervisor_account),
          ListTileAddOptionsWidget(
              onTap: () {
                Navigator.of(context).pushNamed('/customerRegistration');
              },
              title: 'CADASTRAR CLIENTE',
              color: orange,
              icon: Icons.person_add_alt_1),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        color: blue,
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
