import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/car_rental_state.dart';
import 'package:ss_auto/view/widgets/floating_action_button_widget.dart';

import 'widgets/bottom_app_bar_widget.dart';

class CarRentalPage extends StatelessWidget {
  const CarRentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color blu = const Color(0xff052b57);
    Color orange = const Color(0xffD3393A);
    return ChangeNotifierProvider(
      create: (context) => CarRentalState(),
      child: Consumer<CarRentalState>(
        builder: (_,state, __) {
          return Scaffold(
            body: Column(
              children: [
                ElevatedButton(
                  child: Text('pressMe'),
                  onPressed:() => state.showCalendarDialog,
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButtonWidget(
              color: blue,
            ),
            bottomNavigationBar: BottomAppBarWidget(),
          );
        }
      ),
    );
  }
}
