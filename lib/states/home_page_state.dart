import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/agency_controller.dart';
import '../controller/customer_controller.dart';
import '../controller/rental_controller.dart';
import '../controller/vehicle_controller.dart';
import '../model/chart_model.dart';

/// CREATING THE STATE OF THE CUSTOMER LIST PAGE
class HomePageState with ChangeNotifier {
  /// STATE BUILDER
  HomePageState() {
    addBars();
    getRentalStats();
    setValues();
  }

  /// CONTROLLER RENTAL FROM DATABASE
  final rentalController = RentalController();

  /// CONTROLLER VEHICLE FROM DATABASE
  final vehicleController = VehicleController();

  /// CONTROLLER CUSTOMER FROM DATABASE
  final customerController = CustomerController();

  /// CONTROLLER AGENCY FROM DATABASE
  final agencyController = AgencyController();

  /// BAR GROUP
  final barGroup1 = BarChartGroupData(x: 50);

  /// LIST CHART MODEL
  List<ChartModel> list = [];

  /// ITEMS LIST BAR CHART
  final items = <BarChartGroupData>[];

  /// LIST OF RAW BAR GROUPS
  List<BarChartGroupData> rawBarGroups = [];

  /// FUNCTION TO SET BARS GROUP
  BarChartGroupData makeGroupData(int x, double y) {
    final color = barColors[x % barColors.length];
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  /// TOTAL RENTS IN PROGRESS
  double inProgressCount = 0;
  /// TOTAL RENTS FINISHED
  double finishedCount = 0;
  /// TOTAL RENDS NOT REMOVED
  double notRemovedCount = 0;

  /// FUNCTION TO GET RENTAL STATS
  Future<void> getRentalStats() async {
    final stats = await rentalController.selectRentalStats();
    final statusCount = countStatuses(stats);

    notRemovedCount = (statusCount['nao retirado'] ?? 0).toDouble();
    finishedCount = (statusCount['finalizado'] ?? 0).toDouble();
    inProgressCount = (statusCount['em andamento'] ?? 0).toDouble();
  }

  /// TOTAL RENTS REGISTERED
  int? totalRents;
  /// TOTAL CUSTOMERS REGISTERED
  int? totalCustomers;
  /// TOTAL AGENCYS REGISTERED
  int? totalAgencys;
  /// TOTAL VEHICLES REGISTERED
  int? totalVehicles;

  /// FUNCTION TO SET VALUES
  Future<void> setValues() async {
    totalRents = await rentalController.getTotalRecords() ?? 0;
    totalCustomers = await customerController.getTotalRecords() ?? 0;
    totalAgencys = await agencyController.getTotalRecords() ?? 0;
    totalVehicles = await vehicleController.getTotalRecords() ?? 0;
    notifyListeners();
  }

  /// FUNCTION TO COUNT HOW MUCH ITEMS ARE IN DATABASE
  Map<String, int> countStatuses(List<String> statuses) {
    final countMap = {
      'nao retirado': 0,
      'finalizado': 0,
      'em andamento': 0,
    };

    for (var status in statuses) {
      if (countMap.containsKey(status)) {
        countMap[status] = countMap[status]! + 1;
      }
    }

    return countMap;
  }

  /// MAX Y IN GRAPHIC
  double maxY = 0;

  /// LIST OF COLORS BARS
  final List<Color> barColors = [
    const Color(0xFF34495e),
    const Color(0xFF8e44ad),
    const Color(0xFF2980b9),
    const Color(0xFF27ae60),
    const Color(0xFFf39c12),
    const Color(0xFFca122e),
  ];

  /// FUNCTION TO ADD BARS IN LIST
  void addBars() async {
    final lista = await rentalController.rentalsMonth();

    list = lista;

    for (var i = 0; i < lista.length; i++) {
      if (lista[i].total == null) {
        continue;
      }

      if (lista[i].total! > maxY) {
        maxY = lista[i].total!;
      }

      items.add(makeGroupData(i, lista[i].total!));
    }

    rawBarGroups = items;
    notifyListeners();
  }

  /// FUNCTION TO GET MONTHS FROM DATABASE
  String getTitlesWidget(double value, _) {
    final date = list
        .where(
          (element) => element.index == value.toInt(),
        )
        .first;
    return getAbbreviatedMonth(date.month);
  }

  /// SWITCH TO RENAME MONTHS
  String getAbbreviatedMonth(String date) {
    final month = date.split('-')[1];

    switch (month) {
      case '01':
        return 'Jan';
      case '02':
        return 'Fev';
      case '03':
        return 'Mar';
      case '04':
        return 'Abr';
      case '05':
        return 'Mai';
      case '06':
        return 'Jun';
      case '07':
        return 'Jul';
      case '08':
        return 'Ago';
      case '09':
        return 'Set';
      case '10':
        return 'Out';
      case '11':
        return 'Nov';
      case '12':
        return 'Dez';
      default:
        return 'Mês inválido';
    }
  }
}
