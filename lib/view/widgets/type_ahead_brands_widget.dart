import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

import '../../model/brands_model.dart';

class TypeAheadBrandsWidget extends StatelessWidget {

  final TextEditingController controller;
  final Future<void> Function() getBrands;
  final Future<void> Function() getModels;
  final Function(Brands) onBrandSelected;
  final List<Brands> brandsList;

  TypeAheadBrandsWidget({
    super.key,
    required this.controller,
    required this.getBrands,
    required this.getModels,
    required this.onBrandSelected,
    required this.brandsList
  });

  Color blue = const Color(0xff011329);
  Color orange = const Color(0xffD3393A);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Brands>(
      controller: controller,
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          await getBrands(); // Carrega as marcas quando o campo estiver vazio
          return brandsList;
        }
        return brandsList
            .where((brand) => brand.name!.toLowerCase().contains(pattern.toLowerCase()))
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
        controller.text = suggestion.name!.toUpperCase();
        onBrandSelected(suggestion);
      },
    );
  }
}
