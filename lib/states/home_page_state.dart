import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class HomePageState with ChangeNotifier {

  HomePageState() {
    addSpots();
  }

  List<int> monthlyEarnings = [1000, 1500, 2000, 1800, 2500];
  List<String> monthLabels = ['jan', 'fev', 'mar', 'abr','mai'];

  List<FlSpot> spots = [];

  void addSpots() {
    for (int i = 0; i < monthlyEarnings.length; i++) {
      spots.add(FlSpot(i.toDouble(), monthlyEarnings[i].toDouble()));
    }
  }
}
