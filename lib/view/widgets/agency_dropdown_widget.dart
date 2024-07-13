import 'package:flutter/material.dart';
import '../../model/agency_model.dart';

/// CREATION OF STATELESS WIDGET
class AgencyDropdownWidget extends StatelessWidget {
  /// LIST OF AGENCYS
  final List<Agency> list;

  /// AGENCY SELECTED
  final Agency? selectedItem;

  /// FUNCTION ON THE DROPDOWN IS CHANGED
  final void Function(Agency?)? onChanged;

  /// STATELESS WIDGET BUILDER
  const AgencyDropdownWidget(
      {required this.list,
      required this.selectedItem,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30,
        ),
        color: Colors.white,
      ),
      child: Center(
        child: DropdownButton<Agency>(
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          borderRadius: BorderRadius.circular(20),
          value: selectedItem,
          dropdownColor: Colors.white,
          underline: const DropdownButtonHideUnderline(
            child: Text(''),
          ),
          iconEnabledColor: Colors.white,
          onChanged: onChanged,
          items: [
            ...list.map((agency) {
              return DropdownMenuItem<Agency>(
                value: agency,
                child: Text(agency.agencyName),
              );
            }),
          ],
        ),
      ),
    );
  }
}
