import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

class FleetPage extends StatelessWidget {
  const FleetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => VehicleRegistrationState(),
        child: Consumer<VehicleRegistrationState>(
          builder: (_, state, __) {
            return ListView.builder(
              itemCount: state.listVehicles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Card(
                    key: ValueKey(state.listVehicles[index].id),
                    color: Colors.grey,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ExpansionTile(
                      title: Text(
                        state.listVehicles[index].model,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
