import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {

  final Color color;

  const FloatingActionButtonWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: color,
      onPressed: () {
        Navigator.of(context).pushNamed('/addOptionsPage');
      },
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
