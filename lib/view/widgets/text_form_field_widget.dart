import 'package:flutter/material.dart';

/// CREATION OF STATELESS WIDGET
class TextFormFieldWidget extends StatelessWidget {
  /// TITLE TEXT FORM FIELD
  final String title;
  /// CONTROLLER
  final TextEditingController? controller;

  /// CREATION OF STATELESS WIDGET
  const TextFormFieldWidget({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          height: 30,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
