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
  RentalCompletionState(double dailyCost, DateTime startA, DateTime endA) {
    loadAgency();
    loadCustomers();
    calculateDateTotal(dailyCost, startA, endA);
  }

  DateTime? selectedDatePickUp;
  DateTime? selectedDateDeliver;
  int? daysRent;
  double? totalRent;

  void calculateDateTotal(double? dailyCost, DateTime? startA, DateTime? endA) {
    if (startA != null && endA != null) {
      Duration difference = endA.difference(startA);
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

  Future<void> insertRental(int vehicleCode, int agencyCode, String datePickUp,
      String dateDeliver, DateTime? startA, int customerCode) async {
    final rent = Rental(
      rentalCost: totalRent!,
      rentalRegisterDate: DateTime.now().toString(),
      rentalStart: datePickUp,
      rentalEnd: dateDeliver,
      rentalStats: getRentalStats(startA!, rentalPaymentStats),
      rentalPaymentStats: getRentalPaymentStats(),
      customerCode: customerCode,
      agencyCode: agencyCode,
      vehicleCode: vehicleCode,
    );
    print(rent);
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

    return saveDocument(name: 'Example.pdf', pdf: pdf);
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
    if (await file.exists()) {
      final url = file.path;
      print(url);
      await OpenFile.open(url);
    } else {
      print('O arquivo não existe: ${file.path}');
    }
  }

}
