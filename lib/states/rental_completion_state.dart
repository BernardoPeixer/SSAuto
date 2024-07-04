import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import 'package:ss_auto/controller/rental_controller.dart';
import 'package:ss_auto/model/rental_model.dart';
import '../controller/agency_controller.dart';
import '../model/agency_model.dart';
import '../model/customer_model.dart';

class RentalCompletionState with ChangeNotifier {
  RentalCompletionState() {
    loadAgency();
    loadCustomers();
    print(_customerList);
    print(_listAgency);
  }

  TextEditingController dateControllerPickUp = TextEditingController();
  TextEditingController dateControllerDeliver = TextEditingController();

  DateTime? selectedDatePickUp;
  DateTime? selectedDateDeliver;
  int? daysRent;
  double? totalRent;

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

  Future<void> selectDateDeliver(
      BuildContext context, double? dailyCost) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateControllerDeliver.text = picked.toString().split(' ')[0];
      selectedDateDeliver = picked;
      calculateDateTotal(dailyCost);
      notifyListeners();
    }
  }

  void calculateDateTotal(double? dailyCost) {
    if (selectedDatePickUp != null && selectedDateDeliver != null) {
      Duration difference =
          selectedDateDeliver!.difference(selectedDatePickUp!);
      daysRent = difference.inDays;
      totalRent = dailyCost! * daysRent!;
      notifyListeners();
    }
  }

  final controllerAgency = AgencyController();
  final _listAgency = <Agency>[];

  List<Agency> get listAgency => _listAgency;

  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  final controllerCustomer = CustomerController();
  final _customerList = <Customer>[];

  List<Customer> get customerList => _customerList;
  Customer? selectedItem;
  final _controllerDropDownCustomer = TextEditingController();

  TextEditingController get controllerDropDownCustomer =>
      _controllerDropDownCustomer;

  void onCustomerSelected(String suggestion) {
    controllerDropDownCustomer.text = suggestion;
  }

  Future<void> loadCustomers() async {
    final list = await controllerCustomer.selectCustomers();
    _customerList.clear();
    _customerList.addAll(list);
    notifyListeners();
  }

  String? getAgencyName(int? agencyCode) {
    if (agencyCode == null) return null;

    Agency? agency = listAgency.firstWhere(
      (agency) => agency.agencyId == agencyCode,
      orElse: () => Agency(
          agencyId: -1,
          agencyName: 'Desconhecida',
          agencyState: '',
          agencyCity: ''),
    );
    notifyListeners();

    if (agency != null) {
      notifyListeners();
      return agency.agencyName;
    } else {
      return null;
    }
  }

  final controllerRental = RentalController();
  String rentalStats = 'EM ANDAMENTO';
  bool rentalPaymentStats = true;

  String getRentalPaymentStats() {
    if (rentalPaymentStats == true) {
      return 'PAGO';
    } else {
      return 'A PAGAR';
    }
  }

  int differenceNowRentalEnd(DateTime rentalEnd) {
    Duration difference = rentalEnd.difference(DateTime.now());
    final differenceInDays = difference.inDays;

    return differenceInDays;
  }

  String getRentalStats(DateTime rentalEnd, bool rentalPaymentStats) {
    if (differenceNowRentalEnd(rentalEnd) < 0 && rentalPaymentStats == true) {
      return 'FINALIZADO';
    } else {
      return 'EM ANDAMENTO';
    }
  }

  Future<void> insertRental(int vehicleCode, int agencyCode) async {
    int? customerCode = await controllerCustomer
        .getCustomerIdByName(controllerDropDownCustomer.text);
    final rent = Rental(
      rentalCost: totalRent!,
      rentalRegisterDate: DateTime.now().toString(),
      rentalStart: dateControllerPickUp.text,
      rentalEnd: dateControllerDeliver.text,
      rentalStats: getRentalStats(selectedDateDeliver!, rentalPaymentStats),
      rentalPaymentStats: getRentalPaymentStats(),
      customerCode: customerCode,
      agencyCode: agencyCode,
      vehicleCode: vehicleCode,
    );
    await controllerRental.insert(rent);
    notifyListeners();
    print('insert concluido');
  }

  Future<File> generateCenteredText(String text) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(text),
          );
        },
      ),
    );

    return saveDocument(name: 'Example.com', pdf: pdf);
  }

  Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  Future<void> openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
