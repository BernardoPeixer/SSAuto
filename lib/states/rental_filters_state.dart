import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/agency_controller.dart';
import '../controller/customer_controller.dart';
import '../model/agency_model.dart';
import '../model/customer_model.dart';
import '../view/arguments/rental_arguments.dart';

/// CREATING THE STATE OF THE RENTAL FILTERS PAGE PAGE
class RentalFiltersState with ChangeNotifier {
  /// STATE BUILDER
  RentalFiltersState() {
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

  /// CUSTOMER CONTROLLER FROM DATABASE
  final controllerCustomer = CustomerController();

  /// AGENCY CONTROLLER FROM DATABASE
  final controllerAgency = AgencyController();
  final _listAgency = <Agency>[];

  /// INSTANCE OF SELECTED AGENCY
  Agency? selectedAgency;

  /// STEPS BY STEPPER
  int currentSteps = 0;

  /// DATE TIME TO SELECTED DATE TO PICK UP THE CAR
  DateTime? selectedDatePickUp;

  /// DATE TIME TO SELECTED DATE TO DELIVER THE CAR
  DateTime? selectedDateDeliver;

  /// INSTANCE OF SELECTED CUSTOMER
  Customer? selectedCustomer;

  /// GETTER DATE CONTROLLER
  TextEditingController get dateControllerPickUp => _dateControllerPickUp;

  /// GETTER DATE CONTROLLER
  TextEditingController get dateControllerDeliver => _dateControllerDeliver;

  /// GETTER CUSTOMER CONTROLLER TYPE AHEAD
  TextEditingController get customerControllerTypeAhead =>
      _customerControllerTypeAhead;

  /// GETTER AGENCY CONTROLLER TYPE AHEAD
  TextEditingController get agencyControllerTypeAhead =>
      _agencyControllerTypeAhead;

  /// GETTER CUSTOMER LIST
  List<Customer> get listCustomer => _listCustomer;

  /// GETTER AGENCY LIST
  List<Agency> get listAgency => _listAgency;

  /// FORMATED DATE
  String formatedDatePickUp = '';

  /// FUNCTION TO SELECT DATE PICK UP
  Future<void> selectDatePickUp(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerPickUp.text = picked.toString().split(' ')[0];
      selectedDatePickUp = picked;
      formatedDatePickUp = DateFormat('yyyy-MM-dd').format(selectedDatePickUp!);
      notifyListeners();
    }
  }

  /// FORMATED DATE
  String formatedDateDeliver = '';

  /// FUNCTION TO SELECT DATE DELIVER
  Future<void> selectDateDeliver(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerDeliver.text = picked.toString().split(' ')[0];
      selectedDateDeliver = picked;
      formatedDateDeliver =
          DateFormat('yyyy-MM-dd').format(selectedDateDeliver!);
      notifyListeners();
    }
  }

  /// FUNCTION ON STEP CONTINUE
  void onStepContinue(
    BuildContext context,
  ) {
    if (currentSteps < 2) {
      currentSteps += 1;
      notifyListeners();
    } else {
      Navigator.pushNamed(
        context,
        '/carRentalPage',
        arguments: RentalArguments(
          rentalStart: formatedDatePickUp,
          rentalStartA: selectedDatePickUp!,
          rentalEndA: selectedDateDeliver!,
          rentalEnd: formatedDateDeliver,
          selectedAgency: selectedAgency,
          customer: selectedCustomer!,
        ),
      );
    }
  }

  /// FUNCTION ON AGENCY IS SELECTED ON TYPE AHEAD
  void onAgencySelect(Agency agency) {
    selectedAgency = agency;
    notifyListeners();
  }

  /// FUNCTION ON CUSTOMER IS SELECTED ON TYPE AHEAD
  void onCustomerSelect(Customer customer) {
    selectedCustomer = customer;
    notifyListeners();
  }

  /// FUNCTION ON STEP IS CANCEL
  void onStepCancel() {
    if (currentSteps > 0) {
      currentSteps -= 1;
      notifyListeners();
    } else {
      currentSteps = 0;
    }
  }

  /// FUNCTION ON STEP IS TAPPED
  void onStepTapped(int value) {
    currentSteps = value;
    notifyListeners();
  }

  /// FUNCTION TO LOAD CUSTOMERS FROM DATABASE
  Future<void> loadCustomer() async {
    final list = await controllerCustomer.selectCustomers();

    _listCustomer.clear();
    _listCustomer.addAll(list);
    notifyListeners();
  }

  /// FUNCTION TO LOAD AGENCY FROM DATABASE
  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }
}
