import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/rental_list_state.dart';

import 'widgets/bottom_app_bar_widget.dart';

class RentalListPage extends StatelessWidget {
  const RentalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RentalListState(),
      child: Consumer<RentalListState>(
        builder: (_,state,__) {
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
              itemCount: state.listVehicles.length,
              itemBuilder: (context, index) {
                var vehicle = state.listVehicles[index];
                return FutureBuilder<List<String>>(
                  future: state.getListPathImagesCars(
                      state.listVehicles[index].vehicleLicensePlate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Sem imagens disponíveis'));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: state.listVehicles[index].vehicleStats ==
                                'Disponivel'
                                ? Colors.green.shade200
                                : Colors.red.shade200,
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
                            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                        File(snapshot.data![0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vehicle.vehicleModel.length > 10
                                            ? "${vehicle.vehicleModel.substring(0, 10)}..."
                                            : vehicle.vehicleModel,
                                        style: const TextStyle(
                                          color: Color(0xFFca122e),
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Anos: ${vehicle.vehicleYear}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF797979),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Status: ${vehicle.vehicleStats}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: vehicle.vehicleStats ==
                                                      'Disponivel'
                                                      ? Colors.green
                                                      : Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 100,
                                            child: FilledButton(
                                              style: const ButtonStyle(
                                                padding: WidgetStatePropertyAll<
                                                    EdgeInsetsGeometry>(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                ),
                                                backgroundColor:
                                                WidgetStatePropertyAll<Color>(
                                                  Color(0xFFca122e),
                                                ),
                                              ),
                                              onPressed: () {
                                              },
                                              child: const Text(
                                                'DETALHES',
                                                style: TextStyle(fontSize: 12),
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
        }
      ),
    );
  }
}
