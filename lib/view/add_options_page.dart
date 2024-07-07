import 'package:flutter/material.dart';
import 'package:ss_auto/view/widgets/list_tile_add_options_widget.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

class AddOptionsPage extends StatelessWidget {
  const AddOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);
    return Scaffold(
      backgroundColor: const Color(0xFFca122e),
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFca122e),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/logo/ss_horizontal_logo.png',
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTileAddOptionsWidget(
                onTap: () {
                  Navigator.of(context).pushNamed('/vehicleRegistrationPage');
                },
                title: 'ADICIONAR CARRO',
                color: Colors.white,
                icon: Icons.directions_car_outlined),
            ListTileAddOptionsWidget(
                onTap: () {
                  Navigator.of(context).pushNamed('/managerRegistrationPage');
                },
                title: 'CADASTRAR GERENTE',
                color: Colors.white,
                icon: Icons.supervisor_account_outlined),
            ListTileAddOptionsWidget(
                onTap: () {
                  Navigator.of(context).pushNamed('/customerRegistrationPage');
                },
                title: 'CADASTRAR CLIENTE',
                color: Colors.white,
                icon: Icons.person_add_alt_1_outlined),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomAppBarWidget(),
      ),
    );
  }
}
