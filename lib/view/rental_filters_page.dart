import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/rental_filters_state.dart';

import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/fab_widget.dart';
import 'widgets/type_ahead_agencys_widget.dart';
import 'widgets/type_ahead_customers_widget.dart';

/// CREATION OF STATELESS WIDGET
class RentalFiltersPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const RentalFiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RentalFiltersState(),
      child: Consumer<RentalFiltersState>(builder: (_, state, __) {
        return Scaffold(
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
                          'ALUGUÉIS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo/ss_simples_logo.png',
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Stepper(
            type: StepperType.horizontal,
            elevation: 0,
            stepIconMargin: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            onStepContinue: () => state.onStepContinue(context),
            onStepCancel: state.onStepCancel,
            currentStep: state.currentSteps,
            onStepTapped: state.onStepTapped,
            steps: [
              Step(
                isActive: state.currentSteps >= 0,
                state: state.currentSteps >= 0
                    ? StepState.indexed
                    : StepState.disabled,
                title: const Text(''),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'DATA DA LOCAÇÃO',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
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
                        const SizedBox(width: 12.0),
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Step(
                isActive: state.currentSteps >= 1,
                state: state.currentSteps >= 1
                    ? StepState.indexed
                    : StepState.disabled,
                title: const Text(''),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Selecione o cliente',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TypeAheadCustomersWidget(
                      controller: state.customerControllerTypeAhead,
                      customerList: state.listCustomer,
                      onSelectCustomer: state.onCustomerSelect,
                    ),
                  ],
                ),
              ),
              Step(
                isActive: state.currentSteps >= 2,
                state: state.currentSteps >= 2
                    ? StepState.indexed
                    : StepState.disabled,
                title: const Text(''),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Selecione uma agência',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TypeAheadAgencysWidget(
                      controller: state.agencyControllerTypeAhead,
                      agencyList: state.listAgency,
                      onAgencySelect: state.onAgencySelect,
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFFca122e),
            height: 80,
            child: const BottomAppBarWidget(),
          ),
          floatingActionButton: const FabWidget(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      }),
    );
  }
}
