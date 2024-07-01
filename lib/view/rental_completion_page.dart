import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states/rental_completion_state.dart';
import 'arguments/car_arguments.dart';

class RentalCompletionPage extends StatelessWidget {
  const RentalCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CarArguments args =
        ModalRoute.of(context)!.settings.arguments as CarArguments;
    final vehicle = args.vehicle;
    return ChangeNotifierProvider(
      create: (context) => RentalCompletionState(),
      child: Consumer<RentalCompletionState>(builder: (_, state, __) {
        return Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: const Text(
              'Pagamento',
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      20,
                    ),
                    bottomRight: Radius.circular(
                      20,
                    ),
                  ),
                  child: Image.file(
                    File(args.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vehicle.vehicleModel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: state.dateControllerPickUp,
                        decoration: const InputDecoration(
                          label: Text('Retirada'),
                          filled: true,
                          prefix: Icon(Icons.calendar_today),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async => state.selectDatePickUp(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: state.dateControllerDeliver,
                        decoration: const InputDecoration(
                          label: Text('Entrega'),
                          filled: true,
                          prefix: Icon(Icons.calendar_today),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          state.selectDateDeliver(
                            context,
                            vehicle.vehicleDailyCost,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Total: ${state.totalRent ?? ''}',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Agência: ${vehicle.agencyCode}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Ano: ${vehicle.vehicleYear}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Diária: R\$${vehicle.vehicleDailyCost}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Ano: 2020',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.blueGrey),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Registrar aluguél!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
