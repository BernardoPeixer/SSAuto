import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/vehicle_controller.dart';
import '../model/vehicle_model.dart';

/// CREATING THE STATE OF THE CUSTOMER LIST PAGE
class FleetPageState with ChangeNotifier {
  final List<Vehicle> _filtredVehicles = [];
  final _listVehicles = <Vehicle>[];

  /// STATE BUILDER
  FleetPageState() {
    loadVehicle();
  }

  final TextEditingController _appBarController = TextEditingController();

  /// GETTER SEARCH BAR CONTROLLER
  TextEditingController get appBarController => _appBarController;

  /// GETTER FILTRED VEHICLES
  List<Vehicle> get filtredVehicles => _filtredVehicles;

  /// FUNCTION TO ON SEARCH BAR CHANGED
  void onChanged(String query) {
    if (query.isNotEmpty) {
      _filtredVehicles.clear();
      _filtredVehicles.addAll(_listVehicles.where((vehicle) =>
          vehicle.vehicleModel.toLowerCase().contains(query.toLowerCase())));
    } else {
      _filtredVehicles.clear();
      _filtredVehicles.addAll(_listVehicles);
    }
    notifyListeners();
  }

  /// GETTER LIST VEHICLES
  List<Vehicle> get listVehicles => _listVehicles;

  /// VEHICLE CONTROLLER FROM DATABASE
  final controllerVehicle = VehicleController();

  /// FUNCTION TO LOAD VEHICLES FROM DATABASE
  Future<void> loadVehicle() async {
    final list = await controllerVehicle.selectVehicles();
    _listVehicles.clear();
    _listVehicles.addAll(list);
    _filtredVehicles.addAll(_listVehicles);
    onChanged(_appBarController.text);
    notifyListeners();
  }

  /// FUNCTION TO GET PATH IMAGES CARS
  Future<String> getPathImagesCars(String licensePlate) async {
    final appDocumentsDir = await getApplicationSupportDirectory();

    final finalPath = '${appDocumentsDir.path}/images/cars/$licensePlate/0.png';

    return finalPath;
  }

  /// FUNCTION TO GET LIST PATHS IMAGES CAR
  Future<List<String>> getListPathImagesCars(String licensePlate) async {
    try {
      final appDocumentsDir = await getApplicationSupportDirectory();
      final pathCars = '${appDocumentsDir.path}/images/cars/$licensePlate';

      var paths = <String>[];

      for (var i = 0; i < 5; i++) {
        final path = '$pathCars/$i.png';
        if (File(path).existsSync()) {
          paths.add(path);
        }
      }

      return paths;
    } catch (e) {
      return [];
    }
  }
}
