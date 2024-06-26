import 'package:flutter/material.dart';
import '../../model/agency_model.dart';

class AgencyDropdownWidget extends StatelessWidget {
  final List<Agency> list;
  final Agency? selectedItem;
  final void Function(Agency?)? onChanged;

  const AgencyDropdownWidget(
      {required this.list,
      required this.selectedItem,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);
    return DropdownButton<Agency>(
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      value: selectedItem,
      dropdownColor: blue,
      onChanged: onChanged,
      items: [
        ...list.map((Agency agency) {
          return DropdownMenuItem<Agency>(
            value: agency,
            child: Text(agency.agencyName),
          );
        }),
      ],
    );
  }
}
