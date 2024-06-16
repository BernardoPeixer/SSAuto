import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';
import 'package:ss_auto/view/widgets/teste_widget.dart';

import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

class FleetPage extends StatelessWidget {
  const FleetPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => VehicleRegistrationState(),
        child: Consumer<VehicleRegistrationState>(
          builder: (_, state, __) {
            return Scaffold(
              body: ListView.builder(
                itemCount: state.listVehicles.length,
                itemBuilder: (context, index) {
                  return Cartao();
                },
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        color: blue,
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
