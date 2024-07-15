import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// CREATION OF STATELESS WIDGET
class PieChartWidget extends StatelessWidget {
  /// FIRST SECTION OF PIE CHART
  final double? sectionOne;
  /// SECOND SECTION OF PIE CHART
  final double? sectionTwo;
  /// THIRD SECTION OF PIE CHART
  final double? sectionThree;
  /// STATELESS WIDGET BUILDER
  const PieChartWidget({
    super.key,
    required this.sectionOne,
    required this.sectionTwo,
    required this.sectionThree,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: sectionOne,
            color: Colors.green,
            showTitle: false,
            titleStyle: const TextStyle(
              fontSize: 8,
            ),
          ),
          PieChartSectionData(
            value: sectionTwo,
            color: Colors.blue,
            showTitle: false,
            titleStyle: const TextStyle(
              fontSize: 8,
            ),
          ),
          PieChartSectionData(
            value: sectionThree,
            color: Colors.yellow,
            showTitle: false,
            titleStyle: const TextStyle(
              fontSize: 8,
            ),
          )
        ],
      ),
    );
  }
}
