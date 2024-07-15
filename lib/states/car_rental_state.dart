import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../controller/rental_controller.dart';
import '../model/vehicle_model.dart';

/// CREATING THE STATE OF THE CAR RENTAL PAGE
class CarRentalState with ChangeNotifier {
  List<Vehicle> _listVehicles = [];
  final List<Vehicle> _filtredVehicles = [];

  /// STATE BUILDER
  CarRentalState(int agencyId, String rentalStart, String rentalEnd) {
    loadVehicles(agencyId, rentalStart, rentalEnd);
  }

  /// GETTER LIST VEHICLES
  List<Vehicle> get listVehicles => _listVehicles;
  /// GETTER LIST FILTRED VEHICLES
  List<Vehicle> get filtredVehicles => _filtredVehicles;

  /// FUNCTION TO GET PATH IMAGES CAR
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

      final paths = <String>[];

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

  /// CONTROLLER RENTAL FROM DATABASE
  final rentalController = RentalController();

  /// FUNCTION CALLED WHEN INIT PAGE
  Future<void> loadVehicles(
      int agencyId, String rentalStart, String rentalEnd) async {
      _filtredVehicles.clear();
      _listVehicles.clear();
      _listVehicles = await rentalController.selectFilteredVehicles(
          agencyId, rentalStart, rentalEnd);
      _filtredVehicles.addAll(_listVehicles);
      onChanged(_appBarController.text);
      notifyListeners();
  }

  final TextEditingController _appBarController = TextEditingController();

  /// CONTROLLER TEXT FROM SEARCH BAR
  TextEditingController get appBarController => _appBarController;

  /// FUNCTION ON SEARCH BAR IS CHANGED
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
}
