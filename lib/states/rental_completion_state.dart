import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  String formattedDateTimeNow() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

    return formattedDate;
  }

  String formattedDateTime(DateTime rentalDate) {
    String formattedDate = DateFormat('dd/MM').format(rentalDate);

    return formattedDate;
  }

  Future<List<Uint8List>> convertFile(List<String> listImages) async {
    List<Uint8List> listConvert = [];
    for (int i = 0; i < listImages.length; i++) {
      String imagePath = listImages[i];
      File imageFile = File(imagePath);

      if (imageFile.existsSync()) {
        Uint8List bytes = await imageFile.readAsBytes();
        listConvert.add(bytes);
      } else {
        print('Failed to load image at path: $imagePath');
      }
    }
    return listConvert;
  }

  Future<File> proofOfRental(
    String agencyName,
    String customerName,
    String customerCnpj,
    String vehicleModel,
    String vehicleBrand,
    List<String> images,
    String pickUpDate,
    String deliverDate,
    double dailyCost,
    String customerPhone,
    String customerCity,
    String customerState,
  ) async {
    final pdf = pw.Document();
    final ByteData logoData =
        await rootBundle.load('assets/images/logo/ss_horizontal_logo.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final logoImage = pw.MemoryImage(logoBytes);

    final convertFiles = await convertFile(images);

    const PdfColor pdfColor = PdfColor.fromInt(0xFFca122e);

    final pw.TextStyle appBarTextStyle = pw.TextStyle(
      color: PdfColors.white,
      fontSize: 20,
      fontWeight: pw.FontWeight.bold,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Container(
                width: double.infinity,
                height: 80,
                decoration: const pw.BoxDecoration(
                  color: pdfColor,
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Image(logoImage, height: 80 - 16),
                    ),
                    pw.Expanded(
                      child: pw.Center(
                        child: pw.Text(
                          agencyName,
                          style: appBarTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          '''Cliente: ${customerName.toUpperCase()}
                          CNPJ: $customerCnpj
                          Telefone: $customerPhone
                          Cidade: $customerCity
                          Estado: $customerState
                          ''',
                          style: const pw.TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          'Agência de Viagem: ${agencyName.toUpperCase()}',
                          style: const pw.TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    pw.Divider(),
                    pw.Row(
                      children: [
                        pw.Text(
                            'Geracao do comprovante: ${formattedDateTimeNow()}'),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Text('Marca: $vehicleBrand - Modelo: $vehicleModel'),
                      ],
                    ),
                    pw.Text(
                      'Fotos do Veículo:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Row(
                      children: convertFiles
                          .map(
                            (bytes) => pw.Container(
                              margin: const pw.EdgeInsets.only(right: 10),
                              width: 100,
                              height: 100,
                              child: pw.Image(pw.MemoryImage(bytes),
                                  fit: pw.BoxFit.cover),
                            ),
                          )
                          .toList(),
                    ),
                    pw.Row(
                      children: [
                        pw.Text('Retirada: $pickUpDate  Entrega: $deliverDate'),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                            'Custo diário: $dailyCost, Custo total: $totalRent'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return saveDocument(name: '$customerName - $vehicleModel.pdf', pdf: pdf);
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
