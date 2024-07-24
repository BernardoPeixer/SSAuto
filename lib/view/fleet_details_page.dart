import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/agency_model.dart';
import '../model/vehicle_model.dart';
import '../states/fleet_details_state.dart';
import 'arguments/arguments_fleet_page.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/carousel_slider_widget.dart';

/// CREATION OF STATELESS WIDGET
class FleetDetailsPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const FleetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ArgumentsFleetPage;

    return ChangeNotifierProvider(
      create: (context) => FleetDetailsState(),
      child: Consumer<FleetDetailsState>(builder: (_, state, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFca122e),
            actions: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
          body: FutureBuilder<Vehicle?>(
            future: state.setVehicle(args.id),
            builder: (context, snapshot) {
              {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('Vehicle not found.'));
                }
                final vehicle = snapshot.data!;
                return FutureBuilder<Agency?>(
                    future: state.setAgency(vehicle.agencyCode),
                    builder: (context, agencySnapshot) {
                      if (agencySnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (agencySnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${agencySnapshot.error}'));
                      } else if (!agencySnapshot.hasData ||
                          agencySnapshot.data == null) {
                        return const Center(child: Text('Agency not found.'));
                      }

                      final agency = agencySnapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSliderWidget(imagesPath: args.paths),
                          const SizedBox(height: 12.0),
                          Text(
                            vehicle.vehicleModel,
                            style: const TextStyle(
                              color: Color(0xffca122e),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                color: Colors.grey.shade300,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'DIÁRIA:',
                                          style: TextStyle(
                                            color: Color(0xFFca122e),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'RS ${vehicle.vehicleDailyCost}/dia',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      width: 1.5,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'STATUS:',
                                            style: TextStyle(
                                              color: Color(0xFFca122e),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            vehicle.vehicleStats,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: vehicle.vehicleStats ==
                                                  'Disponivel'
                                                  ? Colors.green
                                                  : const Color(0xFFca122e),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                color: Colors.grey.shade300,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'PLACA:',
                                            style: TextStyle(
                                              color: Color(0xFFca122e),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            vehicle.vehicleLicensePlate,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      width: 1.5,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'AGÊNCIA:',
                                            style: TextStyle(
                                              color: Color(0xFFca122e),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            agency.agencyName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 130,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFca122e),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await state
                                        .updateVehicleStats(
                                      vehicle.vehicleId!, vehicle,);
                                  },
                                  child: Text(
                                    vehicle.vehicleStats == 'Disponivel'
                                        ? 'Desativar'
                                        : 'Ativar',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              }
            },
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFFca122e),
            height: 80,
            child: const BottomAppBarWidget(),
          ),
        );
      }),
    );
  }
}