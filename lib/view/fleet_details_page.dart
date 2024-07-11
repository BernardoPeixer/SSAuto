import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/fleet_details_state.dart';
import 'package:ss_auto/view/arguments/car_arguments.dart';
import 'package:ss_auto/view/widgets/carousel_slider_widget.dart';

import 'widgets/bottom_app_bar_widget.dart';

class FleetDetailsPage extends StatelessWidget {
  const FleetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CarArguments args =
        ModalRoute.of(context)!.settings.arguments as CarArguments;
    final vehicle = args.vehicle;
    return ChangeNotifierProvider(
      create: (context) => FleetDetailsState(vehicle),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSliderWidget(imagesPath: args.imagePath),
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
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                                  color: vehicle.vehicleStats == 'Disponivel'
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
                    color: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'PLACA',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xffca122e),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vehicle.vehicleLicensePlate,
                              style: const TextStyle(fontSize: 16),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 130,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/vehicleRegistrationPage');
                      },
                      child: const Text(
                        'Editar',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
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
                        await state.updateVehicleStats(vehicle.vehicleId!);
                      },
                      child: Text(
                        args.vehicle.vehicleStats == 'Disponivel'
                            ? 'Desativar'
                            : 'Ativar',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
