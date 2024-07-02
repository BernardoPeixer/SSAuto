import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/view/widgets/car_rent_filter_widget.dart';

import '../controller/vehicle_controller.dart';
import '../model/vehicle_model.dart';

class CarRentalState with ChangeNotifier {
  CarRentalState() {
    loadVehicle();
  }

  Future<void> showAlertDialog(BuildContext context) async {
    final isClicker = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CarRentFilterWidget();
        });
  }

  final _listVehicles = <Vehicle>[];

  List<Vehicle> get listVehicles => _listVehicles;
  final controllerVehicle = VehicleController();

  Future<void> loadVehicle() async {
    final list = await controllerVehicle.selectVehicles();
    _listVehicles.clear();
    _listVehicles.addAll(list);
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
