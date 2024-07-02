import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/fleet_details_state.dart';
import 'package:ss_auto/view/arguments/car_arguments.dart';

class FleetDetailsPage extends StatelessWidget {
  const FleetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    return ChangeNotifierProvider(
      create: (context) => FleetDetailsState(),
      child: Consumer<FleetDetailsState>(builder: (_, state, __) {
        final CarArguments args =
            ModalRoute.of(context)!.settings.arguments as CarArguments;
        final vehicle = args.vehicle;
        return Scaffold(
          backgroundColor: blue,
          appBar: AppBar(
            title: const Text('Dados do veículo'),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                child: Image.file(
                  File(args.imagePath[0]),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              Text(
                '${vehicle.vehicleBrand} | ${vehicle.vehicleModel}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Placa: ${vehicle.vehicleLicensePlate}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                'Ano: ${vehicle.vehicleYear}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                'R\$${vehicle.vehicleDailyCost} P/Dia',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'EDITAR',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.red,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'EXCLUIR',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
