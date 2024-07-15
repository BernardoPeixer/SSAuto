import 'package:flutter/material.dart';

import '../controller/agency_controller.dart';
import '../controller/customer_controller.dart';
import '../controller/rental_controller.dart';
import '../model/agency_model.dart';
import '../model/customer_model.dart';
import '../model/rental_model.dart';

/// CREATING THE STATE OF THE RENTAL LIST DETAILS PAGE PAGE
class RentalListDetailsState with ChangeNotifier {
  /// STATE BUILDER
  RentalListDetailsState(int agencyCode, int customerCode) {
    loadAgency(agencyCode);
    loadCustomer(customerCode);
  }

  /// FUNCTION TO FORMAT DATE
  String formatDateString(String date) {
    final parts = date.split('-');
    return '${parts[2]}/${parts[1]}';
  }

  /// INSTANCE OF AGENCY
  Agency? agency;

  /// INSTANCE OF CUSTOMER
  Customer? customer;

  final _listAgency = <Agency>[];

  /// GETTER LIST AGENCY
  List<Agency> get listAgency => _listAgency;

  /// AGENCY CONTROLLER FROM DATABASE
  final controllerAgency = AgencyController();

  /// LOAD AGENCYS FROM DATABASE
  Future<void> loadAgency(int agencyCode) async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    getAgencyFromRent(agencyCode);
    notifyListeners();
  }

  final _listCustomer = <Customer>[];

  /// GETTER CUSTOMER LIST
  List<Customer> get listCustomer => _listCustomer;

  /// CUSTOMER CONTROLLER FROM DATABASE
  final controllerCustomer = CustomerController();

  /// FUNCTION TO LOAD CUSTOMERS FROM DATABASE
  Future<void> loadCustomer(int customerCode) async {
    final list = await controllerCustomer.selectCustomers();
    _listCustomer.clear();
    _listCustomer.addAll(list);
    getCustomerFromRent(customerCode);
    notifyListeners();
  }

  /// FUNCTION TO GET AGENCY FROM RENT
  void getAgencyFromRent(int agencyCode) {
    agency = _listAgency.firstWhere(
      (agency) => agency.agencyId == agencyCode,
    );
  }

  /// FUNCTION TO GET CUSTOMER FROM RENT
  void getCustomerFromRent(int customerCode) {
    customer = _listCustomer.firstWhere(
          (customer) => customer.customerId == customerCode,
    );
  }

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
