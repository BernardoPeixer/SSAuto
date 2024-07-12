import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/controller/rental_controller.dart';
import 'package:ss_auto/model/rental_model.dart';
import '../controller/vehicle_controller.dart';
import '../model/vehicle_model.dart';

class RentalListState with ChangeNotifier {
  RentalListState() {
    loadRentals();
    loadVehicles();
  }

  final _listVehicles = <Vehicle>[];

  List<Vehicle> get listVehicles => _listVehicles;
  final controllerVehicle = VehicleController();

  final controllerRental = RentalController();

  void sortRentalsByStatus() {
    _listRentals.sort(
      (a, b) {
        int statusPriority(String status) {
          switch (status) {
            case 'atrasado':
              return 0;
            case 'em andamento':
              return 1;
            case 'nao retirado':
              return 2;
            case 'finalizado':
              return 3;
            default:
              return 4;
          }
        }

        return statusPriority(a.rentalStats)
            .compareTo(statusPriority(b.rentalStats));
      },
    );

    notifyListeners();
  }

  Future<void> loadVehicles() async {
    final list = await controllerVehicle.selectVehicles();
    _listVehicles.addAll(list);
    notifyListeners();
  }

  final _listRentals = <Rental>[];

  List<Rental> get listRentals => _listRentals;
  final controllerRentals = RentalController();

  Future<void> loadRentals() async {
    final list = await controllerRentals.selectRentals();
    _listRentals.addAll(list);
    sortRentalsByStatus();
    notifyListeners();
  }

  Vehicle? getVehicleForRent(int vehicleCode) {
    try {
      return _listVehicles
          .firstWhere((vehicle) => vehicle.vehicleId == vehicleCode);
    } catch (e) {
      return null;
    }
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

  Color returnColorContainer(String rentalStats) {
    if (rentalStats == 'nao retirado') {
      return const Color(0xFFBBDEFB);
    }
    if (rentalStats == 'em andamento') {
      return const Color(0xFFFFF9C4);
    }
    if (rentalStats == 'finalizado') {
      return const Color(0xFFC8E6C9);
    }
    return const Color(0xFFFFCDD2);
  }

  Color returnColorText(String rentalStats) {
    if (rentalStats == 'nao retirado') {
      return const Color(0xFF0D47A1);
    }
    if (rentalStats == 'em andamento') {
      return const Color(0xFFF57F17);
    }
    if (rentalStats == 'finalizado') {
      return const Color(0xFF388E3C);
    }
    return const Color(0xFFC62828);
  }

  String formatDateString(String date) {
    List<String> parts = date.split('-');
    return '${parts[2]}/${parts[1]}';
  }
}
