import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/rental_controller.dart';
import '../controller/vehicle_controller.dart';
import '../model/rental_model.dart';
import '../model/vehicle_model.dart';

/// CREATING THE STATE OF THE RENTAL LIST PAGE
class RentalListState with ChangeNotifier {
  /// STATE BUILDER
  RentalListState() {
    loadRentals();
  }

  /// VEHICLE CONTROLLER FROM DATABASE
  final controllerVehicle = VehicleController();

  /// RENTAL CONTROLLER FROM DATABASE
  final controllerRental = RentalController();

  /// FUNCTION TO SORT RENTAL BY STATS
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

  final _listRentals = <Rental>[];

  /// GETTER RENTALS LIST
  List<Rental> get listRentals => _listRentals;

  /// RENTALS CONTROLLER FROM DATABASE
  final controllerRentals = RentalController();

  /// FUNCTION TO LOAD RENTALS FROM DATABASE
  Future<void> loadRentals() async {
    final list = await controllerRentals.selectRentals();
    _listRentals.addAll(list);
    sortRentalsByStatus();
    notifyListeners();
  }

  /// FUNCTION TO SET VEHICLE BY ID
  Future<Vehicle?> setVehicleById(int vehicleId) async {
    final vehicle = await controllerVehicle.getVehicleById(vehicleId);
    return vehicle;
  }

  /// FUNCTION TO GET LIST PATH IMAGES CAR
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

  /// FUNCTION TO RETURN CONTAINER COLOR
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

  /// FUNCTION TO RETURN COLOR TEXT
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

  /// FUNCTION TO FORMAT DATE
  String formatDateString(String date) {
    final parts = date.split('-');
    return '${parts[2]}/${parts[1]}';
  }
}
