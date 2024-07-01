import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../controller/agency_controller.dart';
import '../model/agency_model.dart';

class RentalCompletionState with ChangeNotifier {
  RentalCompletionPage() {
    loadAgency();
  }

  TextEditingController dateControllerPickUp = TextEditingController();
  TextEditingController dateControllerDeliver = TextEditingController();

  DateTime? selectedDatePickUp;
  DateTime? selectedDateDeliver;
  int? daysRent;
  double? totalRent;

  Future<void> selectDatePickUp(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerPickUp.text = picked.toString().split(' ')[0];
      selectedDatePickUp = picked;
      notifyListeners();
    }
  }

  Future<void> selectDateDeliver(BuildContext context, double? dailyCost) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerDeliver.text = picked.toString().split(' ')[0];
      selectedDateDeliver = picked;
      calculateDateTotal(dailyCost);
      notifyListeners();
    }
  }

  void calculateDateTotal(double? dailyCost) {
    if (selectedDatePickUp != null && selectedDateDeliver != null) {
      Duration difference =
          selectedDateDeliver!.difference(selectedDatePickUp!);
      daysRent = difference.inDays;
      totalRent = dailyCost! * daysRent!;
      notifyListeners();
    }
  }

  final controllerAgency = AgencyController();
  final _listAgency = <Agency>[];

  List<Agency> get listAgency => _listAgency;

  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  String? getAgencyName(int agencyCode) {
    Agency? agency = listAgency.firstWhere(
      (agency) => agency.agencyId == agencyCode,
    );
    notifyListeners();
    return agency.agencyName;
  }
}
