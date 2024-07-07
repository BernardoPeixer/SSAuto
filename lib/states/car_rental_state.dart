import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/controller/rental_controller.dart';
import '../model/vehicle_model.dart';

class CarRentalState with ChangeNotifier {
  List<Vehicle> _listVehicles = [];
  final List<Vehicle> _filtredVehicles = [];

  CarRentalState(int agencyId, String rentalStart, String rentalEnd) {
    loadVehicles(agencyId, rentalStart, rentalEnd);
    print(filtredVehicles.length);
  }

  List<Vehicle> get listVehicles => _listVehicles;
  List<Vehicle> get filtredVehicles => _filtredVehicles;

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

  final rentalController = RentalController();

  Future<void> loadVehicles(
      int agencyId, String rentalStart, String rentalEnd) async {
    try {
      _filtredVehicles.clear();
      _listVehicles.clear();
      _listVehicles = await rentalController.selectFilteredVehicles(
          agencyId, rentalStart, rentalEnd);
      _filtredVehicles.addAll(_listVehicles);
      onChanged(_appBarController.text);
      notifyListeners();
    } catch (e) {
      print('Error loading vehicles: $e');
    }
  }

  final TextEditingController _appBarController = TextEditingController();

  TextEditingController get appBarController => _appBarController;

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
