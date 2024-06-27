import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../states/calendar_alert_dialog_state.dart';

class CalendarAlertDialogWidget extends StatelessWidget {

  const CalendarAlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarAlertDialogState(),
      child: Consumer<CalendarAlertDialogState>(
        builder: (_,state, __) {
          return AlertDialog(
            title: const Text(
              'Selecione um dia:',
            ),
            content: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 31, 12),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              onDaySelected: (selectedDay, focusedDay) {
                state.setSelectedDay;
              },
              selectedDayPredicate: (day) {
                return isSameDay(state.selectedDay, day);
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Selecionar'),
                onPressed: () {
                  print(state.selectedDay);
                  Navigator.of(context).pop(state.selectedDay);
                },
              ),
            ],

          );
        }
      ),
    );
  }
}
