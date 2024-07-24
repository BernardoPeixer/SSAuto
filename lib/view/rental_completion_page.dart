import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/manager_model.dart';
import '../states/rental_completion_state.dart';
import 'arguments/arguments_completion_rental.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/carousel_slider_widget.dart';

/// CREATION OF STATELESS WIDGET
class RentalCompletionPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const RentalCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ArgumentsCompletionRental;
    return ChangeNotifierProvider(
      create: (context) => RentalCompletionState(),
      child: Consumer<RentalCompletionState>(builder: (_, state, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFFca122e),
              actions: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_left,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const Center(
                            child: Text(
                          'DETALHES DO VEÍCULO',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                        Image.asset(
                          'assets/images/logo/ss_simples_logo.png',
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
          body: FutureBuilder<List<dynamic>>(
            future: Future.wait([
              state.setVehicleById(args.vehicleId),
              state.setCustomerById(args.customerId),
            ]),
            builder: (context, snapshotVehicle) {
              {
                if (snapshotVehicle.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshotVehicle.hasError) {
                  return Center(child: Text('Error: ${snapshotVehicle.error}'));
                } else if (!snapshotVehicle.hasData ||
                    snapshotVehicle.data == null) {
                  return const Center(child: Text('Agency not found!'));
                }
                final vehicle = snapshotVehicle.data![0];
                final customer = snapshotVehicle.data![1];
                return FutureBuilder<List<dynamic>>(
                    future: Future.wait([
                      state.setAgencyById(vehicle!.agencyCode),
                      state.calculateDateTotal(vehicle.vehicleDailyCost,
                          args.rentalStartA, args.rentalEndA),
                    ]),
                    builder: (context, snapshotAgency) {
                      {
                        if (snapshotAgency.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshotAgency.hasError) {
                          return Center(
                              child: Text('Error: ${snapshotAgency.error}'));
                        } else if (!snapshotAgency.hasData ||
                            snapshotAgency.data == null) {
                          return const Center(child: Text('Agency not found!'));
                        }
                        final agency = snapshotAgency.data![0];

                        return FutureBuilder<Manager?>(
                            future: state.setManagerById(agency.managerCode!),
                            builder: (context, snapshotManager) {
                              {
                                if (snapshotManager.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshotManager.hasError) {
                                  return Center(
                                      child: Text(
                                          'Error: ${snapshotManager.error}'));
                                } else if (!snapshotManager.hasData ||
                                    snapshotManager.data == null) {
                                  return const Center(
                                      child: Text('Manager not found!'));
                                }
                              }
                              final manager = snapshotManager.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CarouselSliderWidget(
                                      imagesPath: args.listPaths),
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
                                  Center(
                                    child: Text(
                                      'Anos: ${vehicle.vehicleYear}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF797979)),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color(0xFF797979),
                                      ),
                                      Text(
                                        '${state.formattedDateTime(
                                          args.rentalStartA,
                                        )} até ${state.formattedDateTime(
                                          args.rentalEndA,
                                        )}',
                                        style: const TextStyle(
                                            color: Color(0xFF797979),
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.grey.shade300,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
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
                                                  'R\$ ${vehicle.vehicleDailyCost.toStringAsFixed(2).replaceAll('.', ',')}/dia',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              width: 1.5,
                                              height: 50,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'TOTAL:',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFca122e),
                                                          fontSize: 12),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4),
                                                    ),
                                                    Text(
                                                      'R\$ ${state.totalRent!.toStringAsFixed(2).replaceAll('.', ',')}',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.grey.shade300,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
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
                                                    'CLIENTE:',
                                                    style: TextStyle(
                                                      color: Color(0xFFca122e),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    customer.customerName,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              width: 1.5,
                                              height: 50,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'COMISSÃO:',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFca122e),
                                                          fontSize: 12),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4),
                                                    ),
                                                    Text(
                                                      'R\$ ${state.calculateCommission(
                                                            manager
                                                                .managerCommission,
                                                          )!.toStringAsFixed(2).replaceAll('.', ',')}',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                        width: 150,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFFca122e),
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async {
                                            await state.insertRental(
                                              vehicle.vehicleId!,
                                              vehicle.agencyCode,
                                              args.rentalStart,
                                              args.rentalEnd,
                                              args.rentalEndA,
                                              customer.customerId!,
                                            );
                                            Navigator.pushNamed(
                                                context, '/homePage');
                                            final pdfFile =
                                                await state.proofOfRental(
                                              agency,
                                              customer.customerName,
                                              customer.customerCnpj,
                                              vehicle.vehicleModel,
                                              vehicle.vehicleBrand,
                                              args.listPaths,
                                              args.rentalStartA,
                                              args.rentalEndA,
                                              vehicle.vehicleDailyCost,
                                              customer.customerPhone,
                                              customer.customerCity,
                                              customer.customerState,
                                              manager,
                                              state.calculateTotalDays(
                                                  args.rentalStartA,
                                                  args.rentalEndA),
                                              vehicle.vehicleLicensePlate,
                                            );
                                            state.openFile(pdfFile);
                                          },
                                          child: const Text(
                                            'Registrar aluguel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      }
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
