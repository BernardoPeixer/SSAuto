import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/rental_list_details_state.dart';
import 'package:ss_auto/view/arguments/argument_teste.dart';
import 'package:ss_auto/view/widgets/carousel_slider_widget.dart';

import 'widgets/bottom_app_bar_widget.dart';

class RentalListDetailsPage extends StatelessWidget {
  const RentalListDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArgumentTeste args =
        ModalRoute.of(context)!.settings.arguments as ArgumentTeste;
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
        create: (context) => RentalListDetailsState(
            args.vehicle.agencyCode, args.rental.customerCode!),
        child: Consumer<RentalListDetailsState>(
          builder: (_, state, __) {
            if (state.listAgency.isEmpty || state.listCustomer.isEmpty) {
              return const Column(
                children: [
                  Text(
                    'Nenhum aluguél realizado!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  CarouselSliderWidget(imagesPath: args.imagesPaths),
                  const SizedBox(height: 12.0),
                  Text(
                    args.vehicle.vehicleModel,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'TOTAL:',
                                  style: TextStyle(
                                    color: Color(0xFFca122e),
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  'RS ${args.rental.rentalCost.toStringAsFixed(2)}',
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
                                    args.rental.rentalStats.toUpperCase(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PERÍODO:',
                                  style: TextStyle(
                                    color: Color(0xFFca122e),
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  '${state.formatDateString(args.rental.rentalStart)} - ${state.formatDateString(args.rental.rentalEnd)}',
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
                                    state.agency!.agencyName,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'CLIENTE:',
                                  style: TextStyle(
                                    color: Color(0xFFca122e),
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  state.customer!.customerName,
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
                    visible: args.rental.rentalStats != 'finalizado',
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
                              args.rental, args.rental.rentalId!);
                        },
                        child: Text(
                          args.rental.rentalStats == 'nao retirado'
                              ? 'Iniciar locação'
                              : 'Finalizar locação',
                          style:
                              const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFca122e),
        height: 80,
        child: const BottomAppBarWidget(),
      ),
    );
  }
}
