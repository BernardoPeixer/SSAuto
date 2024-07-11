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
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30,
        ),
        color: blue,
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
          dropdownColor: blue,
          underline: const DropdownButtonHideUnderline(
            child: Text(''),
          ),
          iconEnabledColor: Colors.white,
          onChanged: onChanged,
          items: [
            ...list.map((Agency agency) {
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
