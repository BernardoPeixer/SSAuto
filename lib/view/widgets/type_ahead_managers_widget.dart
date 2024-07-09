import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../model/customer_model.dart';
import '../../model/manager_model.dart';
import '../../model/models_model.dart';

class TypeAheadManagersWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<Manager> managerList;
  final void Function(Manager) onSelectManager;

  TypeAheadManagersWidget({
    super.key,
    required this.controller,
    required this.managerList,
    required this.onSelectManager,
  });

  Color blue = const Color(0xff011329);
  Color orange = const Color(0xffD3393A);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Manager>(
      controller: controller,
      suggestionsCallback: (pattern) async {
        return managerList
            .where(
              (manager) => manager.managerName.toLowerCase().contains(
                    pattern.toLowerCase(),
                  ),
            )
            .toList();
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Selecione um gerente',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
            fillColor: Colors.white,
            filled: true,
          ),
        );
      },
      itemBuilder: (context, Manager suggestion) {
        return ListTile(
          title: Text(suggestion.managerName.toUpperCase()),
        );
      },
      onSelected: (Manager suggestion) {
        controller.text = suggestion.managerName.toUpperCase();
        onSelectManager(suggestion);
      },
    );
  }
}
