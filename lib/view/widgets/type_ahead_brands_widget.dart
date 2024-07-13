import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../model/brands_model.dart';

/// CREATION OF STATELESS WIDGET
class TypeAheadBrandsWidget extends StatelessWidget {
  /// CONTROLLER FROM TYPEAHEAD
  final TextEditingController controller;
  /// FUNCTION GET BRANDS FROM API
  final Future<void> Function() getBrands;
  /// FUNCTION GET MODELS FROM API
  final Future<void> Function() getModels;
  /// FUNCTION ON BRANDS IS SELECT IN DROPDOWN
  final Function(Brands) onBrandSelected;
  /// BRANDS LIST
  final List<Brands> brandsList;

  /// STATELESS WIDGET BUILDER
  const TypeAheadBrandsWidget({
    super.key,
    required this.controller,
    required this.getBrands,
    required this.getModels,
    required this.onBrandSelected,
    required this.brandsList,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Brands>(
      controller: controller,
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          await getBrands();
          return brandsList;
        }
        return brandsList
            .where((brand) =>
                brand.name!.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.name!.toUpperCase()),
        );
      },
      onSelected: (suggestion) {
        controller.text = suggestion.name!.toUpperCase();
        onBrandSelected(suggestion);
      },
    );
  }
}
