import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {

  final Color color;

  const MyFloatingActionButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: color,
      onPressed: () {
        Navigator.of(context).pushNamed('/addOptionsScreen');
      },
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
