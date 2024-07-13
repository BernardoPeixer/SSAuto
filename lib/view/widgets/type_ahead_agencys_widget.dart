import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../model/agency_model.dart';

/// CREATION OF STATELESS WIDGET
class TypeAheadAgencysWidget extends StatelessWidget {
  /// CONTROLLER FROM TYPEAHEAD
  final TextEditingController controller;
  /// AGENCY LIST
  final List<Agency> agencyList;
  /// FUNCTION ON AGENCY IS SELECT IN DROPDOWN
  final void Function(Agency) onAgencySelect;

  /// STATELESS WIDGET BUILDER
  const TypeAheadAgencysWidget({
    super.key,
    required this.controller,
    required this.agencyList,
    required this.onAgencySelect,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Agency>(
      controller: controller,
      suggestionsCallback: (pattern) async {
        return agencyList
            .where((agency) =>
                agency.agencyName.toLowerCase().contains(pattern.toLowerCase()))
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
            hintText: 'Selecione uma agência',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.agencyName.toUpperCase()),
        );
      },
      onSelected: (suggestion) {
        controller.text = suggestion.agencyName.toUpperCase();
        onAgencySelect(suggestion);
      },
    );
  }
}
