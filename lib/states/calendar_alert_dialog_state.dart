import 'package:flutter/material.dart';

class CalendarAlertDialogState with ChangeNotifier {

  DateTime? selectedDay;

  void setSelectedDay(DateTime? dateTime) {
    selectedDay = dateTime;
    notifyListeners();
  }



}