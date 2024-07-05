import 'package:flutter/material.dart';

import '../controller/agency_controller.dart';
import '../controller/customer_controller.dart';
import '../model/agency_model.dart';
import '../model/customer_model.dart';

class StepByStepState with ChangeNotifier {
  StepByStepState() {
    loadCustomer();
    loadAgency();
  }

  final TextEditingController _dateControllerPickUp = TextEditingController();
  final TextEditingController _dateControllerDeliver = TextEditingController();
  final TextEditingController _customerControllerTypeAhead =
      TextEditingController();
  final TextEditingController _agencyControllerTypeAhead =
      TextEditingController();
  final _listCustomer = <Customer>[];
  final controllerCustomer = CustomerController();
  final controllerAgency = AgencyController();
  final _listAgency = <Agency>[];
  Agency? selectedAgency;
  int currentSteps = 0;
  DateTime? selectedDatePickUp;
  DateTime? selectedDateDeliver;
  int? daysRent;
  double? totalRent;

  TextEditingController get dateControllerPickUp => _dateControllerPickUp;

  TextEditingController get dateControllerDeliver => _dateControllerDeliver;

  TextEditingController get customerControllerTypeAhead =>
      _customerControllerTypeAhead;

  TextEditingController get agencyControllerTypeAhead =>
      _agencyControllerTypeAhead;

  List<Customer> get listCustomer => _listCustomer;

  List<Agency> get listAgency => _listAgency;

  Future<void> selectDatePickUp(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerPickUp.text = picked.toString().split(' ')[0];
      selectedDatePickUp = picked;
      notifyListeners();
    }
  }

  Future<void> selectDateDeliver(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerDeliver.text = picked.toString().split(' ')[0];
      selectedDateDeliver = picked;
      notifyListeners();
    }
  }

  void onStepContinue(
    BuildContext context,
  ) {
    if (currentSteps < 2) {
      currentSteps += 1;
      notifyListeners();
    } else {
      Navigator.pushNamed(context, '/carRentalPage', arguments: selectedAgency);
    }
  }

  void onAgencySelect(Agency agency) {
    selectedAgency = agency;
    notifyListeners();
  }

  void onStepCancel() {
    if (currentSteps > 0) {
      currentSteps -= 1;
      notifyListeners();
    } else {
      currentSteps = 0;
    }
  }

  void onStepTapped(int value) {
    currentSteps = value;
    notifyListeners();
  }

  Future<void> loadCustomer() async {
    final list = await controllerCustomer.selectCustomers();

    _listCustomer.clear();
    _listCustomer.addAll(list);
    notifyListeners();
  }

  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }
}
