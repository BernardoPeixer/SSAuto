import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

import '../../model/models_model.dart';

class TypeAheadModelsWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<Models> modelsList;
  final Future<void> Function() getModels;
  final Function(Models) onModelSelected;

  TypeAheadModelsWidget({
    super.key,
    required this.controller,
    required this.modelsList,
    required this.getModels,
    required this.onModelSelected,
  });

  Color blue = const Color(0xff011329);
  Color orange = const Color(0xffD3393A);

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
      itemBuilder: (context, Models suggestion) {
        return ListTile(
          title: Text(suggestion.name.toUpperCase()),
        );
      },
      onSelected: (Models suggestion) {
        controller.text = suggestion.name.toUpperCase();
        onModelSelected(suggestion);

      },
    );
  }
}
