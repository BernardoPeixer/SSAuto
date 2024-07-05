import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/controller/rental_controller.dart';
import '../model/vehicle_model.dart';

class CarRentalState with ChangeNotifier {
  CarRentalState(int agencyId, String rentalStart, String rentalEnd) {
    print(rentalStart);
    print(rentalEnd);
    loadVehicles(agencyId, rentalStart, rentalEnd);

  }

  var _listVehicles = <Vehicle>[];

  List<Vehicle> get listVehicles => _listVehicles;

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
    _listVehicles = await rentalController.selectFilteredVehicles(
        agencyId, rentalStart, rentalEnd);
    notifyListeners();
  }
}
