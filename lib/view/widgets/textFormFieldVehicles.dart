import 'package:flutter/material.dart';

class TextFormFieldVehicles extends StatelessWidget {
  final String title;
  final Color color;

  const TextFormFieldVehicles({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.2,
          height: 30,
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: color,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
