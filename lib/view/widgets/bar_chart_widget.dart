import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// CREATION OF STATELESS WIDGET
class BarChartWidget extends StatelessWidget {
  /// MAX Y FROM BAR CHART
  final double maxY;
  /// LIST OF RAW BARS
  final List<BarChartGroupData> rawBarGroups;
  /// FUNCTION TO GET TITLES
  final String Function(double value, dynamic _) getTitlesWidget;

  /// STATELESS WIDGET BUILDER
  const BarChartWidget({
    super.key,
    required this.maxY,
    required this.rawBarGroups,
    required this.getTitlesWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: maxY,
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                return Text(
                  getTitlesWidget(value, _),
                  style: const TextStyle(color: Colors.black54),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (x, y) => leftTitles(x, y, context),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: rawBarGroups,
        gridData: FlGridData(
            show: true,
            horizontalInterval: maxY > 0 ? maxY / 10 : 1,
            drawHorizontalLine: true,
            drawVerticalLine: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                  'R\$${rod.toY.toStringAsFixed(0)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ));
            },
          ),
        ),
      ),
    );
  }

  /// LEFT TITLES VALUES
  Widget leftTitles(double value, TitleMeta meta, BuildContext context) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    String text;
    if (value == maxY / 3) {
      text = 'R\$ ${(maxY / 3).toStringAsFixed(0)}';
    } else if (value == maxY / 2) {
      text = 'R\$ ${(maxY / 2).toStringAsFixed(0)}';
    } else if (value == maxY) {
      text = 'R\$ ${maxY.toStringAsFixed(0)}';
    } else {
      return Container();
    }

    return Transform.translate(
      offset: const Offset(0, 10),
      child: SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text, style: style, textAlign: TextAlign.left),
      ),
    );
  }
}
