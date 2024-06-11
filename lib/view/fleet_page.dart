import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          color: orange,
                          height: MediaQuery.of(context).size.height / 4,
                          child: ListTile(
                            key: ValueKey(state.listVehicles[index].id),
                            leading: Text(state.listVehicles[index].year),
                            title: Text(state.listVehicles[index].model),
                            subtitle: Text(state.listVehicles[index].dailyCost),
                            trailing: Text(state.listVehicles[index].brand),
                          ),
                        ),
                      ],
                    ),
                  );
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
