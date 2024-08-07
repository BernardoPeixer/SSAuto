import 'dart:io';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../model/vehicle_model.dart';
import '../states/rental_list_state.dart';

import 'arguments/arguments_rental_list_details.dart';
import 'widgets/bottom_app_bar_widget.dart';

/// CREATION OF STATELESS WIDGET
class RentalListPage extends StatelessWidget {
  /// STATELESS WIDGET STATE
  const RentalListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RentalListState(),
      child: Consumer<RentalListState>(builder: (_, state, __) {
        return Scaffold(
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
          body: ListView.builder(
            itemCount: state.listRentals.length,
            itemBuilder: (context, index) {
              final rent = state.listRentals[index];
              if (state.listRentals.isEmpty) {
                return const CircularProgressIndicator();
              }
              return FutureBuilder<Vehicle?>(
                  future: state.setVehicleById(rent.vehicleCode!),
                  builder: (context, snapshotVehicle) {
                    if (snapshotVehicle.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshotVehicle.hasError) {
                      return Center(
                          child: Text('Erro: ${snapshotVehicle.error}'));
                    } else if (!snapshotVehicle.hasData) {
                      return const Center(
                          child: Text('Não foi possível encontrar veículos'));
                    }
                    final vehicle = snapshotVehicle.data;
                    return FutureBuilder<List<String>>(
                      future: state
                          .getListPathImagesCars(vehicle!.vehicleLicensePlate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Sem imagens disponíveis'));
                        }
                        final paths = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  state.returnColorContainer(rent.rentalStats),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Container(
                                      width: 120,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(
                                              paths.isNotEmpty ? paths[0] : ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vehicle.vehicleModel.length > 10
                                              ? '${vehicle.vehicleModel.
                                          substring(
                                                  0,
                                                  10,
                                                )}...'
                                              : vehicle.vehicleModel,
                                          style: const TextStyle(
                                            color: Color(0xFFca122e),
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'Período: ${state.formatDateString(
                                            rent.rentalStart,
                                          )} - ${state.formatDateString(
                                            rent.rentalEnd,
                                          )}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF797979),
                                          ),
                                        ),
                                        Text(
                                          'Status: ${rent.rentalStats.
                                          toUpperCase()}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: state.returnColorText(
                                                rent.rentalStats),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 24,
                                              width: 100,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFFca122e),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                ),
                                                onPressed: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    '/rentalListDetailsPage',
                                                    arguments:
                                                    ArgumentsRentalListDetails(
                                                      paths: paths,
                                                      rentId: rent.rentalId!,
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'DETALHES',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
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
