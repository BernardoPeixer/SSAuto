import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/car_rental_state.dart';
import 'arguments/arguments_completion_rental.dart';
import 'arguments/arguments_rental_filters.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/rental_card_car_widget.dart';
import 'widgets/search_bar_widget.dart';

/// CREATION OF STATELESS WIDGET
class CarRentalPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const CarRentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ArgumentsRentalFilters;

    return ChangeNotifierProvider(
      create: (context) =>
          CarRentalState(args.agencyId, args.rentalStart, args.rentalEnd),
      child: Consumer<CarRentalState>(
        builder: (_, state, __) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/logo/ss_horizontal_logo.png',
                          height: 80,
                        ),
                        SearchBarWidget(
                          controller: state.appBarController,
                          onChanged: (query) {
                            state.onChanged(query);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: state.filtredVehicles.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum veículo encontrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.filtredVehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = state.filtredVehicles[index];
                      return FutureBuilder<List<dynamic>>(
                        future: Future.wait(
                          [
                            state.getListPathImagesCars(
                                vehicle.vehicleLicensePlate),
                          ],
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final imagePaths = snapshot.data![0] ?? [];
                            return RentalCardCarWidget(
                              vehicleModel: vehicle.vehicleModel,
                              imagePath:
                                  imagePaths.isNotEmpty ? imagePaths[0] : '',
                              vehicleDailyCost: vehicle.vehicleDailyCost,
                              vehicleYear: vehicle.vehicleYear,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/rentalCompletionPage',
                                  arguments: ArgumentsCompletionRental(
                                    vehicleId: vehicle.vehicleId!,
                                    listPaths: snapshot.data![0],
                                    rentalStart: args.rentalStart,
                                    rentalStartA: args.rentalStartA,
                                    rentalEnd: args.rentalEnd,
                                    rentalEndA: args.rentalEndA,
                                    customerId: args.customerId,
                                  ),
                                  // arguments: OtherRentalArguments(
                                  //   rentalStart: args.rentalStart,
                                  //   rentalEnd: args.rentalEnd,
                                  //   rentalStartA: args.rentalStartA,
                                  //   rentalEndA: args.rentalEndA,
                                  //   selectedAgency: agency,
                                  //   vehicle: vehicle,
                                  //   imagePath: imagePaths,
                                  //   customer: args.customer,
                                  // ),
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
            bottomNavigationBar: Container(
              color: const Color(0xFFca122e),
              height: 80,
              child: const BottomAppBarWidget(),
            ),
          );
        },
      ),
    );
  }
}
