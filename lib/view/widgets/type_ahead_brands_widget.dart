import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

import '../../model/brands_model.dart';

class TypeAheadBrandsWidget extends StatelessWidget {
  TypeAheadBrandsWidget({
    super.key,
  });

  Color blue = const Color(0xff011329);
  Color orange = const Color(0xffD3393A);

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleRegistrationState>(
      builder: (_, state, __) {
        return TypeAheadField<Brands>(
          controller: state.controllerBrand,
          suggestionsCallback: (pattern) async {
            await state.getBrands();
            return state.brandsList
                .where((brand) =>
                    brand.name!.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
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
          itemBuilder: (context, Brands suggestion) {
            return ListTile(
              title: Text(suggestion.name!.toUpperCase()),
            );
          },
          onSelected: (Brands suggestion) {
            state.controllerModel.text = suggestion.name!.toUpperCase();
            state.getModels();
          },
        );
      },
    );
  }
}
