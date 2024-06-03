import 'package:flutter/material.dart';

class ListTileAddOptionsScreen extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  VoidCallback? onTap;

  ListTileAddOptionsScreen(
      {required this.title, required this.color, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.5,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  color,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
            onPressed: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 60,
                      color: Colors.white,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
