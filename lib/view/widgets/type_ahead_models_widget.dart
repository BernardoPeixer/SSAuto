import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../model/models_model.dart';

/// CREATION OF STATELESS WIDGET
class TypeAheadModelsWidget extends StatelessWidget {
  /// CONTROLLER FROM TYPEAHEAD
  final TextEditingController controller;
  /// MODELS LIST
  final List<Models> modelsList;
  /// FUNCTION GET MODELS FROM API
  final Future<void> Function() getModels;
  /// FUNCTION ON MODELS IS SELECT IN DROPDOWN
  final Function(Models) onModelSelected;

  /// STATELESS WIDGET BUILDER
  const TypeAheadModelsWidget({
    super.key,
    required this.controller,
    required this.modelsList,
    required this.getModels,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Models>(
      controller: controller,
      suggestionsCallback: (pattern) async {
        if (modelsList.isEmpty) {
          await getModels();
        }
        return modelsList
            .where((models) =>
            models.name.toLowerCase().contains(pattern.toLowerCase()))
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
          title: Text(suggestion.name.toUpperCase()),
        );
      },
      onSelected: (suggestion) {
        controller.text = suggestion.name.toUpperCase();
        onModelSelected(suggestion);

      },
    );
  }
}
