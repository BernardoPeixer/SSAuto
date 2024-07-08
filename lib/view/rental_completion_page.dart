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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSliderWidget(imagesPath: args.imagePath),
                  const SizedBox(height: 24.0),
                  Center(
                    child: Text(
                      vehicle.vehicleModel,
                      style: const TextStyle(
                        color: Color(0xffca122e),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoContainerWidget(
                        text: 'Agência: ${args.selectedAgency!.agencyName}',
                        color: const Color(0xff011329),
                      ),
                      InfoContainerWidget(
                        text: 'Ano: ${vehicle.vehicleYear}',
                        color: const Color(0xff011329),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LargeInfoContainerWidget(
                        text: 'Diária: R\$${vehicle.vehicleDailyCost}',
                        color: const Color(0xff011329),
                      ),
                      LargeInfoContainerWidget(
                        text: 'Total: R\$${state.totalRent ?? ''}',
                        color: const Color(0xffD3393A),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xff052b57),
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
                        final pdfFile =
                            await state.generateCenteredText('Sample text');
                        try {
                          await state.openFile(pdfFile);

                        } catch (e) {
                          print('Erro ao abrir o arquivo: $e');
                        }
                      },
                      child: const Text(
                        'Registrar aluguel',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
