import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return DatePickerDialog(
      firstDate: DateTime.utc(2020, 1, 1),
      lastDate: DateTime.utc(2030, 1, 1),
      currentDate: DateTime.now(),
    );
  }
}
