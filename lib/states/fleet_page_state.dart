import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/vehicle_controller.dart';
import '../model/vehicle_model.dart';

class FleetPageState with ChangeNotifier {

  final List<Vehicle> _filtredVehicles = [];
  final _listVehicles = <Vehicle>[];

  FleetPageState() {
    loadVehicle();
  }

  final TextEditingController _appBarController = TextEditingController();

  TextEditingController get appBarController => _appBarController;


  List<Vehicle> get filtredVehicles => _filtredVehicles;

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



  List<Vehicle> get listVehicles => _listVehicles;
  final controllerVehicle = VehicleController();

  Future<void> loadVehicle() async {
    final list = await controllerVehicle.selectVehicles();
    _listVehicles.clear();
    _listVehicles.addAll(list);
    _filtredVehicles.addAll(_listVehicles);
    onChanged(_appBarController.text);
    notifyListeners();
  }

  Future<String> getPathImagesCars(String licensePlate) async {
    final appDocumentsDir = await getApplicationSupportDirectory();

    final finalPath = '${appDocumentsDir.path}/images/cars/$licensePlate/0.png';

    return finalPath;
  }

  Future<List<String>> getListPathImagesCars(String licensePlate) async {
    try {
      final appDocumentsDir = await getApplicationSupportDirectory();
      final pathCars = '${appDocumentsDir.path}/images/cars/$licensePlate';

      List<String> paths = [];

      for (int i = 0; i < 5; i++) {
        String path = '$pathCars/$i.png';
        if (File(path).existsSync()) {
          paths.add(path);
        }
      }

      return paths;
    } catch (e) {
      print('Error getting image paths: $e');
      return [];
    }
  }
}
