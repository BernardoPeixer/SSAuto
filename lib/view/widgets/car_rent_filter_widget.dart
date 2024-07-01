import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/agency_model.dart';
import '../../states/car_rent_filter_state.dart';

class CarRentFilterWidget extends StatelessWidget {
  CarRentFilterWidget();

  @override
  Widget build(BuildContext context) {
    String selectedBrand = 'Todas';
    String selectedModel = 'Todos';
    double selectedMinPrice = 0;
    double selectedMaxPrice = 10000;
    return ChangeNotifierProvider(
      create: (context) => CarRentFilterState(),
      child: Consumer<CarRentFilterState>(builder: (_, state, __) {
        return AlertDialog(
            title: const Text('Filtros'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Agências:'),
                DropdownButtonFormField<Agency>(
                    value: state.selectedAgency,
                    decoration: const InputDecoration(
                        hintText: 'Selecione uma agência'),
                    items: [
                      ...state.listAgency.map((Agency agency) {
                        return DropdownMenuItem<Agency>(
                          value: agency,
                          child: Text(agency.agencyName),
                        );
                      }),
                    ],
                    onChanged: (Agency? value) {
                      state.onPressedAgency(value);
                    }),
                DropdownButtonFormField<String>(
                  value: selectedModel,
                  items: const [
                    DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                    DropdownMenuItem(value: 'Argo', child: Text('Argo')),
                    DropdownMenuItem(value: 'Gol', child: Text('Gol')),
                  ],
                  onChanged: (String? newValue) {
                    selectedModel = newValue ?? 'Todos';
                  },
                ),
                const SizedBox(height: 16.0),
                Text('Preços:'),
                RangeSlider(
                  values: RangeValues(selectedMinPrice, selectedMaxPrice),
                  min: 0.0,
                  max: 10000.0,
                  divisions: 10,
                  onChanged: (RangeValues value) {},
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Filtrar'),
              ),
            ]);
      }),
    );
  }
}
