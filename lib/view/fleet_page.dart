import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/fleet_page_state.dart';
import 'package:ss_auto/view/arguments/car_arguments.dart';
import 'package:ss_auto/view/widgets/car_card_widget.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

class FleetPage extends StatelessWidget {
  const FleetPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => FleetPageState(),
        child: Consumer<FleetPageState>(
          builder: (_, state, __) {
            return ListView.builder(
              itemCount: state.listVehicles.length,
              itemBuilder: (context, index) {
                var vehicle = state.listVehicles[index];
                return FutureBuilder<String>(
                  future: state.getPathImagesCars(
                      state.listVehicles[index].vehicleLicensePlate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text(
                        'Sem dados',
                        style: TextStyle(color: Colors.black),
                      );
                    } else {
                      return CarCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/fleetDetailsPage',
                            arguments: CarArguments(
                                vehicle: vehicle, imagePath: snapshot.data!),
                          );
                        },
                        brand: vehicle.vehicleBrand,
                        imagePath: snapshot.data!,
                        year: vehicle.vehicleYear,
                        model: vehicle.vehicleModel,
                        price: vehicle.vehicleDailyCost,
                        status: 'Ativo',
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        color: blue,
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
