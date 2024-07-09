import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/view/arguments/other_rental_arguments.dart';
import 'package:ss_auto/view/widgets/carousel_slider_widget.dart';
import 'package:ss_auto/view/widgets/info_container_widget.dart';
import 'package:ss_auto/view/widgets/large_info_container_widget.dart';
import '../states/rental_completion_state.dart';
import 'widgets/bottom_app_bar_widget.dart';

class RentalCompletionPage extends StatelessWidget {
  const RentalCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OtherRentalArguments args =
        ModalRoute.of(context)!.settings.arguments as OtherRentalArguments;
    final vehicle = args.vehicle;
    return ChangeNotifierProvider(
      create: (context) => RentalCompletionState(
          vehicle.vehicleDailyCost, args.rentalStartA!, args.rentalEndA!),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSliderWidget(imagesPath: args.imagePath),
              const SizedBox(height: 12.0),
              Center(
                child: Text(
                  vehicle.vehicleModel,
                  style: const TextStyle(
                    color: Color(0xffca122e),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Anos: ${vehicle.vehicleYear}',
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF797979)),
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
                    '${state.formattedDateTime(args.rentalStartA!)} até ${state.formattedDateTime(args.rentalEndA!)}',
                    style:
                        const TextStyle(color: Color(0xFF797979), fontSize: 16),
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
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Coluna para o lado esquerdo (DIÁRIA)
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
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'TOTAL:',
                                  style: TextStyle(
                                      color: Color(0xFFca122e), fontSize: 12),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                ),
                                Text(
                                  'R\$ ${vehicle.vehicleDailyCost}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
                    color: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CLIENTE',
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${args.customer.customerName} | CNPJ: ${args.customer.customerCnpj}',
                              style: const TextStyle(fontSize: 10),
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
                        await state.insertRental(
                            vehicle.vehicleId!,
                            vehicle.agencyCode,
                            args.rentalStart,
                            args.rentalEnd,
                            args.rentalEndA,
                            args.customer.customerId!);
                        final pdfFile = await state.proofOfRental(
                          args.selectedAgency!.agencyName,
                          args.customer.customerName,
                          args.customer.customerCnpj,
                          vehicle.vehicleModel,
                          vehicle.vehicleBrand,
                          args.imagePath,
                          args.rentalStart,
                          args.rentalEnd,
                          vehicle.vehicleDailyCost,
                          args.customer.customerPhone,
                          args.customer.customerCity,
                          args.customer.customerState,
                        );
                        try {
                          await state.openFile(pdfFile);
                        } catch (e) {
                          print('Erro ao abrir o arquivo: $e');
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Registrar aluguel',
                        style: TextStyle(color: Colors.white, fontSize: 12),
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
