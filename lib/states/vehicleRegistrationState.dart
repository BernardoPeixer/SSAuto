import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ss_auto/controller/vehicleController.dart';

import '../model/vehicleModel.dart';

class VehicleRegistrationState with ChangeNotifier {
  VehicleRegistrationState({this.vehicle});

  bool isPressedYesButton = false;
  bool isPressedNoButton = false;
  final keyFormVehicle = GlobalKey<FormState>();

  final _controllerBrand = TextEditingController();

  TextEditingController get controllerBrand => _controllerBrand;

  final _controllerModel = TextEditingController();

  TextEditingController get controllerModel => _controllerModel;

  final _controllerLicensePlate = TextEditingController();

  TextEditingController get controllerLicensePlate => _controllerLicensePlate;

  final _controllerYear = TextEditingController();

  TextEditingController get controllerYear => _controllerYear;

  final _controllerCategory = TextEditingController();

  TextEditingController get controllerCategory => _controllerCategory;

  final _controllerDailyCost = TextEditingController();

  TextEditingController get controllerDailyCost => _controllerDailyCost;

  final _controllerMileage = TextEditingController();

  TextEditingController get controllerMileage => _controllerMileage;

  final _controllerColor = TextEditingController();

  TextEditingController get controllerColor => _controllerColor;

  final String controllerAir = 'yes';

  final String controllerSensor = 'yes';

  final controllerVehicle = VehicleController();

  final Vehicle? vehicle;

  String? name(String? value) {
    if (value == null || value.length < 5) {
      return 'O nome deve conter mais de 5 letras';
    }
  }

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

  Future<void> insertVehicle() async {
    print('chamando insert');
    final vehicle = Vehicle(
      brand: controllerBrand.text,
      model: controllerModel.text,
      licensePlate: controllerLicensePlate.text,
      year: controllerYear.text,
      category: controllerCategory.text,
      dailyCost: controllerDailyCost.text,
      mileage: controllerMileage.text,
      color: controllerColor.text,
      air: controllerAir,
      sensor: controllerSensor,
    );
    await controllerVehicle.insert(vehicle);
    controllerBrand.clear();
    controllerModel.clear();
    controllerLicensePlate.clear();
    controllerYear.clear();
    controllerCategory.clear();
    controllerDailyCost.clear();
    controllerMileage.clear();
    controllerColor.clear();
    notifyListeners();
    print('insert concluido');
  }
}
