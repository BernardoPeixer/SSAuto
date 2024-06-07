import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';

class YesNoSelectionWidget extends StatelessWidget {
  final String title;

  YesNoSelectionWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Color orange = const Color(0xffD3393A);

    return ChangeNotifierProvider(
      create: (context) => VehicleRegistrationState(),
      child: Consumer<VehicleRegistrationState>(builder: (context, state, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => state.pressedYesButton(),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          state.isPressedYesButton ? Colors.green : orange),
                    ),
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => state.pressedNoButton(),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          state.isPressedNoButton ? Colors.green : orange),
                    ),
                    child: const Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
