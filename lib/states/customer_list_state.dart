import 'package:flutter/material.dart';
import '../controller/customer_controller.dart';
import '../model/customer_model.dart';

/// CREATING THE STATE OF THE CUSTOMER LIST PAGE
class CustomerListState with ChangeNotifier {

  /// STATE BUILDER
  CustomerListState() {
    loadCustomer();
  }

  final _listCustomer = <Customer>[];

  /// GETTER LIST CUSTOMER
  List<Customer> get listCustomer => _listCustomer;

  /// CUSTOMER CONTROLLER FROM DATABASE
  final controllerCustomer = CustomerController();

  /// FUNCTION TO LOAD CUSTOMER FROM DATABASE
  Future<void> loadCustomer() async {
    final list = await controllerCustomer.selectCustomers();
    _listCustomer.clear();
    _listCustomer.addAll(list);
    notifyListeners();
  }

  /// FUNCTION TO DELETE CUSTOMER FROM DATABASE
  Future<void> delete(Customer customer) async {
    await controllerCustomer.delete(customer);
    await loadCustomer();
    notifyListeners();
  }
}
