import 'package:flutter/material.dart';

/// CREATION OF STATELESS WIDGET
class ListTileAddOptionsWidget extends StatelessWidget {
  /// ICON TILE
  final IconData icon;
  /// TITLE TILE
  final String title;
  /// FUNCTION ON TAP TILE
  final VoidCallback? onTap;

  /// STATELESS WIDGET BUILDER
  const ListTileAddOptionsWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width ,
        height: 100,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(
                Colors.white,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
          onPressed: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20,),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
