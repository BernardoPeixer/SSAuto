import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

class TypeAheadWidget extends StatelessWidget {
  TypeAheadWidget({super.key});

  Color blue = const Color(0xff011329);
  Color orange = const Color(0xffD3393A);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VehicleRegistrationState(),
      child: Consumer<VehicleRegistrationState>(
        builder: (_, state, __) {
          return TypeAheadField<String>(
            controller: state.controllerBrand,
            suggestionsCallback: (pattern) async {
              return await state.getBrandsTest(pattern);
            },
            builder: (context, controller, focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: blue,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 6.0),
                ),
              );
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(_formatBrandSuggestion(suggestion)),
              );
            },
            onSelected: (String suggestion) {
              print('Marca selecionada: $suggestion');
              state.controllerBrand.text = suggestion.toUpperCase();
            },
          );
        },
      ),
    );
  }

  String _formatBrandSuggestion(String brand) {
    return brand.toUpperCase();
  }
}
