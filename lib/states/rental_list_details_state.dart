import 'package:flutter/material.dart';
import 'package:ss_auto/controller/agency_controller.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import 'package:ss_auto/controller/rental_controller.dart';
import 'package:ss_auto/model/customer_model.dart';

import '../model/agency_model.dart';
import '../model/rental_model.dart';

class RentalListDetailsState with ChangeNotifier {
  RentalListDetailsState(int agencyCode, int customerCode) {
    loadAgency(agencyCode);
    loadCustomer(customerCode);
  }

  String formatDateString(String date) {
    List<String> parts = date.split('-');
    return '${parts[2]}/${parts[1]}';
  }

  Agency? agency;
  Customer? customer;

  final _listAgency = <Agency>[];

  List<Agency> get listAgency => _listAgency;
  final controllerAgency = AgencyController();

  Future<void> loadAgency(int agencyCode) async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    getAgencyFromRent(agencyCode);
    notifyListeners();
  }

  final _listCustomer = <Customer>[];

  List<Customer> get listCustomer => _listCustomer;
  final controllerCustomer = CustomerController();

  Future<void> loadCustomer(int customerCode) async {
    final list = await controllerCustomer.selectCustomers();
    _listCustomer.clear();
    _listCustomer.addAll(list);
    getCustomerFromRent(customerCode);
    notifyListeners();
  }

  void getAgencyFromRent(int agencyCode) {
    agency = _listAgency.firstWhere(
      (agency) => agency.agencyId == agencyCode,
    );
  }

  void getCustomerFromRent(int customerCode) {
    customer = _listCustomer.firstWhere(
          (customer) => customer.customerId == customerCode,
    );
  }

  final controllerRental = RentalController();

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
