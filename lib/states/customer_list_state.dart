import 'package:flutter/material.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import '../model/customer_model.dart';

class CustomerListState with ChangeNotifier {
  CustomerListState() {
    loadCustomer();
  }

  final _listCustomer = <Customer>[];

  List<Customer> get listCustomer => _listCustomer;

  final controllerCustomer = CustomerController();

  Future<void> loadCustomer() async {
    final list = await controllerCustomer.selectCustomers();

    _listCustomer.clear();
    _listCustomer.addAll(list);
    for (final customer in _listCustomer) {
      print('Nome: ${customer.company}, Telefone: ${customer.phone}, Cidade: ${customer.city}, Estado: ${customer.state}, CNPJ: ${customer.cnpj}');
    }
    notifyListeners();
  }
}
