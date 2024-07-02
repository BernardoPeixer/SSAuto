import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/view/widgets/carousel_slider_widget.dart';
import 'package:ss_auto/view/widgets/type_ahead_customers_widget.dart';

import '../model/customer_model.dart';
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Pagamento',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSliderWidget(imagesPath: args.imagePath),
                  const SizedBox(height: 24.0),
                  Center(
                    child: Text(
                      vehicle.vehicleModel,
                      style: const TextStyle(
                        color: Color(0xff052b57),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: state.dateControllerPickUp,
                          decoration: const InputDecoration(
                            labelText: 'Retirada',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(fontSize: 14),
                          readOnly: true,
                          onTap: () async => state.selectDatePickUp(context),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          controller: state.dateControllerDeliver,
                          decoration: const InputDecoration(
                            labelText: 'Entrega',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          style: const TextStyle(fontSize: 14),
                          onTap: () async {
                            state.selectDateDeliver(
                              context,
                              vehicle.vehicleDailyCost,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  TypeAheadCustomersWidget(
                    controller: state.controllerDropDownCustomer,
                    customerList: state.customerList,
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoContainer(
                        context,
                        'Agência: ${state.getAgencyName(vehicle.agencyCode)}',
                        const Color(0xff011329),
                      ),
                      _buildInfoContainer(
                        context,
                        'Ano: ${vehicle.vehicleYear}',
                        const Color(0xff011329),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoContainerHighlighted(
                        context,
                        'Diária: R\$${vehicle.vehicleDailyCost}',
                        const Color(0xff011329),
                      ),
                      _buildInfoContainerHighlighted(
                        context,
                        'Total: R\$${state.totalRent ?? ''}',
                        const Color(0xffD3393A),
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
                      onPressed: () async{
                        await state.insertRental();
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
        );
      }),
    );
  }

  Widget _buildInfoContainer(BuildContext context, String text, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 70,
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainerHighlighted(
      BuildContext context, String text, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
