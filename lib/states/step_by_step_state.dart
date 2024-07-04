import 'package:flutter/material.dart';

class StepByStepState with ChangeNotifier {
  final TextEditingController _dateControllerPickUp = TextEditingController();
  final TextEditingController _dateControllerDeliver = TextEditingController();

  TextEditingController get dateControllerPickUp => _dateControllerPickUp;

  TextEditingController get dateControllerDeliver => _dateControllerDeliver;

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

  Future<void> selectDateDeliver(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerDeliver.text = picked.toString().split(' ')[0];
      selectedDateDeliver = picked;
      notifyListeners();
    }
  }

  int currentSteps = 0;

  void onStepContinue() {
    if (currentSteps < 2) {
      currentSteps += 1;
      notifyListeners();
    }
  }

  void onStepCancel() {
    if (currentSteps > 0) {
      currentSteps -= 1;
      notifyListeners();
    } else {
      currentSteps = 0;
    }
  }

  void onStapTapped(value) {
    currentSteps = value;
    notifyListeners();
  }

}
