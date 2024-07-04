import 'package:flutter/material.dart';

class InfoContainerWidget extends StatelessWidget {
  final Color color;
  final String text;

  const InfoContainerWidget(
      {super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 70,
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
