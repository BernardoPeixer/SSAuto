import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/view/widgets/type_ahead_agencys_widget.dart';
import '../states/step_by_step_state.dart';
import 'widgets/type_ahead_customers_widget.dart';

class StepByStepPage extends StatelessWidget {
  const StepByStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StepByStepState(),
      child: Consumer<StepByStepState>(builder: (_, state, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Aluguéis'),
          ),
          body: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            onStepContinue: () {
              state.onStepContinue(context,);
            },
            onStepCancel: state.onStepCancel,
            currentStep: state.currentSteps,
            onStepTapped: state.onStepTapped,
            steps: [
              Step(
                isActive: state.currentSteps >= 0,
                title: Text(''),
                content: Column(
                  children: [
                    Text('Data here'),
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
                title: Text(''),
                content: Column(
                  children: [
                    TypeAheadCustomersWidget(
                      controller: state.customerControllerTypeAhead,
                      customerList: state.listCustomer,
                    ),
                  ],
                ),
              ),
              Step(
                isActive: state.currentSteps >= 2,
                title: Text(''),
                content: Column(
                  children: [
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
        );
      }),
    );
  }
}
