import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/car_rental_state.dart';
import 'package:ss_auto/view/widgets/bottom_app_bar_widget.dart';
import 'package:ss_auto/view/widgets/floating_action_button_widget.dart';

import '../model/agency_model.dart';
import '../model/vehicle_model.dart';
import 'arguments/car_arguments.dart';

class CarRentalPage extends StatelessWidget {
  const CarRentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Agency agency = ModalRoute.of(context)!.settings.arguments as Agency;
    Color blue = const Color(0xff011329);
    return ChangeNotifierProvider(
      create: (context) => CarRentalState(agency.agencyId!),
      child: Consumer<CarRentalState>(builder: (_, state, __) {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search here...',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.listVehicles.length,
                  itemBuilder: (BuildContext context, int index) {
                    Vehicle vehicle = state.listVehicles[index];
                    return FutureBuilder<List<String>>(
                      future: state.getListPathImagesCars(vehicle.vehicleLicensePlate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        List<String> imagePaths = snapshot.data ?? [];

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: const Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(imagePaths.isNotEmpty ? imagePaths[0] : ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vehicle.vehicleModel,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4),
                                        ),
                                        Text(
                                          'Ano: ${vehicle.vehicleYear}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'R\$ ${vehicle.vehicleDailyCost}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 2.5,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/rentalCompletionPage',
                                                    arguments: CarArguments(
                                                      vehicle: vehicle,
                                                      imagePath: imagePaths,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons.shopping_cart),
                                                label: const Text('Alugar'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: blue,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 2.5,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                '/fleetDetailsPage',
                                                arguments: CarArguments(
                                                  vehicle: vehicle,
                                                  imagePath: imagePaths,
                                                ),
                                              );
                                            },
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Mostrar detalhes',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12,
                                                    decoration: TextDecoration.underline,
                                                    decorationThickness: 1.5,
                                                    decorationStyle: TextDecorationStyle.dotted,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButtonWidget(color: blue),
          bottomNavigationBar: BottomAppBarWidget(),
        );
      }),
    );
  }
}
