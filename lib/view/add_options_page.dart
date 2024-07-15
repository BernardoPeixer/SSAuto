import 'package:flutter/material.dart';

// import 'pdf_page.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/list_tile_add_options_widget.dart';

/// CREATION OF STATELESS WIDGET
class AddOptionsPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const AddOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                icon: Icons.directions_car_outlined),
            ListTileAddOptionsWidget(
                onTap: () {
                  Navigator.of(context).pushNamed('/managerRegistrationPage');
                },
                title: 'CADASTRAR GERENTE',
                icon: Icons.supervisor_account_outlined),
            ListTileAddOptionsWidget(
                onTap: () {
                  Navigator.of(context).pushNamed('/customerRegistrationPage');
                },
                title: 'CADASTRAR CLIENTE',
                icon: Icons.person_add_alt_1_outlined),
            ListTileAddOptionsWidget(
                title: 'CADASTRAR AGÊNCIA',
                icon: Icons.business_outlined,
                onTap: () {
                  Navigator.of(context).pushNamed('/agencyRegistrationPage');
                }),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/pdfPage');
            //   },
            //   child: Text('teste'),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 80,
        child: BottomAppBarWidget(),
      ),
    );
  }
}
