import 'package:flutter/material.dart';

class HomePageContainerWidget extends StatelessWidget {
  final String title;
  final String statistic;
  final String subtitle;
  final Color color;
  final double width;
  final double height;
  final double titleFontSize;
  final double subtitleFontSize;
  final double statisticFontSize;

  const HomePageContainerWidget(
      {super.key, required this.title,
      required this.statistic,
      required this.subtitle,
      required this.color,
      required this.width,
      required this.height,
      required this.titleFontSize,
      required this.subtitleFontSize,
      required this.statisticFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    title,
                    softWrap: true,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize),
                  ),
                ),
              ],
            ),
            Text(
              statistic,
              style: TextStyle(
                color: Colors.white,
                fontSize: statisticFontSize,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: subtitleFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
