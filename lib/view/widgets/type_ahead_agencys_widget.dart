import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ss_auto/model/agency_model.dart';

class TypeAheadAgencysWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<Agency> agencyList;
  void Function(Agency) onAgencySelect;



  TypeAheadAgencysWidget({
    super.key,
    required this.controller,
    required this.agencyList,
    required this.onAgencySelect,
  });

  Color blue = const Color(0xff011329);
  Color orange = const Color(0xffD3393A);

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
            hintText: 'Selecione uma agência',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
            icon: const Icon(Icons.business),
          ),
        );
      },
      itemBuilder: (context, Agency suggestion) {
        return ListTile(
          title: Text(suggestion.agencyName.toUpperCase()),
        );
      },
      onSelected: (Agency suggestion) {
        controller.text = suggestion.agencyName.toUpperCase();
        onAgencySelect(suggestion);
      },
    );
  }
}
