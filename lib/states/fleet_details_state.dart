import 'package:flutter/material.dart';
import 'package:ss_auto/controller/vehicle_controller.dart';
import 'package:ss_auto/model/vehicle_model.dart';

import '../controller/agency_controller.dart';
import '../model/agency_model.dart';

/// CREATING THE STATE OF THE CUSTOMER LIST PAGE
class FleetDetailsState with ChangeNotifier {


  Vehicle? _vehicle;

  /// VEHICLE CONTROLLER FROM DATABASE
  final controllerVehicle = VehicleController();
  /// AGENCY CONTROLLER FROM DATABASE
  final controllerAgency = AgencyController();

  /// GETTER INSTANCE OF VEHICLE
  Vehicle? get vehicle => _vehicle;

  /// FUNCTION TO UPDATE VEHICLE STATS
  Future<void> updateVehicleStats(int vehicleId) async {
    if (_vehicle!.vehicleStats == 'Disponivel') {
      vehicle!.vehicleStats = 'Indisponivel';
    } else {
      _vehicle!.vehicleStats = 'Disponivel';
    }
    await controllerVehicle.updateVehicleStats(
        vehicleId, _vehicle!.vehicleStats);
    notifyListeners();
  }

  /// FUNCTION TO GET VEHICLE BY ID
  Future<Vehicle?> setVehicle(int? id) async {
    final vehicle = await controllerVehicle.getVehicleById(id!);
    return vehicle;
  }

  /// FUNCTION TO GET AGENCY BY ID
  Future<Agency?> setAgency(int? id) async {
    final agency = await controllerAgency.getAgencyById(id!);
    return agency;
  }
}
