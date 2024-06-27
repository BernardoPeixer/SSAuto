import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ss_auto/view/widgets/calendar_alert_dialog_widget.dart';

class CarRentalState with ChangeNotifier {
  void showCalendarDialog(BuildContext context) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CalendarAlertDialogWidget();
      },
    );

    if (picked != null) {
      print('Dia selecionado: $picked');
    }
  }

}