import 'package:flutter/material.dart';

/// CREATION OF STATELESS WIDGET
class FabWidget extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/rentalListPage');
      },
      child: const Icon(Icons.remove_red_eye_outlined),
    );
  }
}
