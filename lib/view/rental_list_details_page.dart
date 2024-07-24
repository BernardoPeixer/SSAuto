import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/rental_model.dart';
import '../states/rental_list_details_state.dart';
import 'arguments/arguments_rental_list_details.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/carousel_slider_widget.dart';

/// CREATION OF STATELESS WIDGET
class RentalListDetailsPage extends StatelessWidget {
  /// STATELESS WIDGET STATE
  const RentalListDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ArgumentsRentalListDetails;
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
      body: ChangeNotifierProvider(
        create: (context) => RentalListDetailsState(),
        child: Consumer<RentalListDetailsState>(builder: (_, state, __) {
          return FutureBuilder<Rental>(
              future: state.setRentalById(args.rentId),
              builder: (context, snapshotRental) {
                if (snapshotRental.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshotRental.hasError) {
                  return Center(child: Text('Erro: ${snapshotRental.error}'));
                } else if (!snapshotRental.hasData) {
                  return const Center(
                      child: Text('Não foi possível encontrar o aluguél'));
                }
                final rent = snapshotRental.data;
                return FutureBuilder<List<dynamic>>(
                    future: Future.wait([
                      state.setCustomerById(rent!.customerCode!),
                      state.setAgencyById(rent.agencyCode!),
                      state.setVehicleById(rent.vehicleCode!),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child:
                                Text('Não foi possível encontrar o aluguél'));
                      }
                      final customer = snapshot.data![0];
                      final agency = snapshot.data![1];
                      final vehicle = snapshot.data![2];
                      return Column(
                        children: [
                          CarouselSliderWidget(imagesPath: args.paths),
                          const SizedBox(height: 12.0),
                          Text(
                            vehicle.vehicleModel,
                            style: const TextStyle(
                              color: Color(0xffca122e),
                              fontSize: 18,
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
                                padding: const EdgeInsets.all(12),
                                color: Colors.grey.shade300,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'TOTAL:',
                                          style: TextStyle(
                                            color: Color(0xFFca122e),
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(
                                          'RS ${rent.rentalCost.toStringAsFixed(
                                            2,
                                          )}',
                                          style: const TextStyle(
                                              fontSize: 16,
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
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            rent.rentalStats.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 12,
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
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                color: Colors.grey.shade300,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'PERÍODO:',
                                          style: TextStyle(
                                            color: Color(0xFFca122e),
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(
                                          '${state.formatDateString(
                                            rent.rentalStart,
                                          )} - ${state.formatDateString(
                                            rent.rentalEnd,
                                          )}',
                                          style: const TextStyle(
                                              fontSize: 12,
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
                                            'AGÊNCIA:',
                                            style: TextStyle(
                                              color: Color(0xFFca122e),
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            agency.agencyName,
                                            style: const TextStyle(
                                              fontSize: 12,
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
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                color: Colors.grey.shade300,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'CLIENTE:',
                                          style: TextStyle(
                                            color: Color(0xFFca122e),
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(
                                          customer.customerName,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Visibility(
                            visible: rent.rentalStats != 'finalizado',
                            child: Container(
                              width: 150,
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
                                  await state.updateVehicleStats(
                                      rent, rent.rentalId!);
                                },
                                child: Text(
                                  rent.rentalStats == 'nao retirado'
                                      ? 'Iniciar locação'
                                      : 'Finalizar locação',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              });
        }),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFca122e),
        height: 80,
        child: const BottomAppBarWidget(),
      ),
    );
  }
}
