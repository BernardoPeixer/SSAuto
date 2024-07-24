import 'package:flutter/material.dart';

import '../controller/agency_controller.dart';
import '../controller/customer_controller.dart';
import '../controller/rental_controller.dart';
import '../controller/vehicle_controller.dart';
import '../model/agency_model.dart';
import '../model/customer_model.dart';
import '../model/rental_model.dart';
import '../model/vehicle_model.dart';

/// CREATING THE STATE OF THE RENTAL LIST DETAILS PAGE PAGE
class RentalListDetailsState with ChangeNotifier {

  /// FUNCTION TO FORMAT DATE
  String formatDateString(String date) {
    final parts = date.split('-');
    return '${parts[2]}/${parts[1]}';
  }

  /// GET RENTAL FROM ID
  Future<Rental> setRentalById(int rentalId) async {
    final rental = await controllerRental.getRentalById(rentalId);
    return rental;
  }

  /// GET AGENCY FROM ID
  Future<Agency?> setAgencyById(int agencyId) async {
    final agency = await controllerAgency.getAgencyById(agencyId);
    return agency;
  }

  /// GET CUSTOMER FROM ID
  Future<Customer?> setCustomerById(int customerId) async {
    final customer = await controllerCustomer.getCustomerById(customerId);
    return customer;
  }

  /// GET VEHICLE FROM ID
  Future<Vehicle?> setVehicleById(int vehicleId) async {
    final vehicle = await controllerVehicle.getVehicleById(vehicleId);
    return vehicle;
  }

  /// AGENCY CONTROLLER FROM DATABASE
  final controllerAgency = AgencyController();

  final _listCustomer = <Customer>[];

  /// GETTER CUSTOMER LIST
  List<Customer> get listCustomer => _listCustomer;

  /// CUSTOMER CONTROLLER FROM DATABASE
  final controllerCustomer = CustomerController();

  /// VEHICLE CONTROLLER FROM DATABASE
  final controllerVehicle = VehicleController();

  /// RENTAL CONTROLLER FROM DATABASE
  final controllerRental = RentalController();

  /// FUNCTION TO UPLOAD VEHICLE STATS IN DATABASE
  Future<void> updateVehicleStats(Rental rent, int vehicleId) async {
    if (rent.rentalStats == 'nao retirado') {
      rent.rentalStats = 'em andamento';
    } else if(rent.rentalStats == 'em andamento'){
      rent.rentalStats = 'finalizado';
    }
    await controllerRental.updateRentalStats(
        vehicleId, rent.rentalStats);
    notifyListeners();
  }
}
