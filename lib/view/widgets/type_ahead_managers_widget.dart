import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../model/manager_model.dart';

/// CREATION OF STATELESS WIDGET
class TypeAheadManagersWidget extends StatelessWidget {
  /// CONTROLLER FROM TYPEAHEAD
  final TextEditingController controller;
  /// MANAGERS LIST
  final List<Manager> managerList;
  /// FUNCTION ON MANAGER IS SELECT IN DROPDOWN
  final void Function(Manager) onSelectManager;

  /// STATELESS WIDGET BUILDER
  const TypeAheadManagersWidget({
    super.key,
    required this.controller,
    required this.managerList,
    required this.onSelectManager,
  });

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
      itemBuilder: (context,suggestion) {
        return ListTile(
          title: Text(suggestion.managerName.toUpperCase()),
        );
      },
      onSelected: (suggestion) {
        controller.text = suggestion.managerName.toUpperCase();
        onSelectManager(suggestion);
      },
    );
  }
}
