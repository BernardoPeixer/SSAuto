import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleRegistrationState with ChangeNotifier {
  bool isPressedYesButton = false;
  bool isPressedNoButton = false;

  void pressedNoButton() {
    isPressedNoButton = isPressedNoButton = true;
    isPressedYesButton = isPressedYesButton = false;
    notifyListeners();
  }

  void pressedYesButton() {
    isPressedYesButton = isPressedYesButton = true;
    isPressedNoButton = isPressedNoButton = false;
    notifyListeners();
  }
}
