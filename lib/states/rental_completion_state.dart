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
import '../model/manager_model.dart';

class RentalCompletionState with ChangeNotifier {
  RentalCompletionState(double dailyCost, DateTime startA, DateTime endA) {
    loadAgency();
    loadCustomers();
    loadManager();
    calculateDateTotal(dailyCost, startA, endA);
  }

  DateTime? selectedDatePickUp;
  DateTime? selectedDateDeliver;
  int? daysRent;
  double? totalRent;

  void calculateDateTotal(double? dailyCost, DateTime? startA, DateTime? endA) {
    if (startA != null && endA != null) {
      Duration difference = endA.difference(startA);
      daysRent = difference.inDays + 1;
      totalRent = dailyCost! * daysRent!;
      notifyListeners();
    }
  }

  final _listManager = <Manager>[];

  List<Manager> get listManager => _listManager;
  final controllerAgency = AgencyController();

  Manager? getManagerForAgency(int managerCode, int managerId) {
    return _listManager.firstWhere(
      (manager) => manager.managerId == managerCode,
    );
  }

  Future<void> loadManager() async {
    final List<Manager> list = await controllerAgency.selectManager();
    _listManager.clear();
    _listManager.addAll(list);
    notifyListeners();
  }

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

  int calculateTotalDays(DateTime pickUp, DateTime deliver) {
    Duration difference = deliver.difference(pickUp);
    final differenceInDays = difference.inDays + 1;

    return differenceInDays;
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
    Manager manager,
    int totalDays,
    String vehiclePlate,
  ) async {
    final pdf = pw.Document();
    final ByteData logoData =
        await rootBundle.load('assets/images/logo/ss_horizontal_logo.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final logoImage = pw.MemoryImage(logoBytes);

    final convertFiles = await convertFile(images);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // AppBar
              pw.Container(
                width: double.infinity,
                height: 100,
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                color: const PdfColor.fromInt(0xFFca122e),
                child: pw.Row(
                  children: [
                    pw.Image(logoImage, height: 80),
                    pw.SizedBox(width: 20),
                    pw.Text(
                      'SS Automóveis',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),

              // Informações do Cliente
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(120),
                    1: const pw.FixedColumnWidth(300),
                  },
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Cliente:',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          customerName.toUpperCase(),
                          style: const pw.TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'CNPJ:',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          customerCnpj,
                          style: const pw.TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Telefone:',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          customerPhone,
                          style: const pw.TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Localidade:',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              customerCity,
                              style: const pw.TextStyle(fontSize: 16),
                            ),
                            pw.Text(
                              customerState,
                              style: const pw.TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Detalhes da Locação:',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.grey),
                      columnWidths: {
                        0: pw.FixedColumnWidth(200),
                        1: pw.FixedColumnWidth(220),
                      },
                      children: [
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Data de Emissão do Comprovante:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              formattedDateTimeNow(),
                              style: const pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Marca:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '$vehicleBrand',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Modelo:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '$vehicleModel',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Placa:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '$vehiclePlate',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Retirada:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '$pickUpDate',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Entrega:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '$deliverDate',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Custo Diário:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'R\$ ${dailyCost.toStringAsFixed(2)}',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Custo Total:',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'R\$ ${totalRent!.toStringAsFixed(2)}',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'Fotos do Veículo:',
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: convertFiles
                          .map(
                            (bytes) => pw.Container(
                              width: 80,
                              height: 80,
                              child: pw.Image(
                                pw.MemoryImage(bytes),
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Footer(
                decoration: const pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFFca122e),
                ),
                title: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        '© SS ALUGUÉIS - Todos os direitos reservados',
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: double.infinity,
                height: 100,
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                color: const PdfColor.fromInt(0xFFca122e),
                child: pw.Row(
                  children: [
                    pw.Image(logoImage, height: 80),
                    pw.SizedBox(width: 20),
                    pw.Text(
                      'SS Automóveis',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey),
                columnWidths: {
                  0: const pw.FixedColumnWidth(200),
                  1: const pw.FixedColumnWidth(220),
                },
                children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Gerente responsável:',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        manager.managerName,
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'CPF',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        manager.managerCpf,
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Localidade:',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            manager.managerCity,
                            style: const pw.TextStyle(fontSize: 16),
                          ),
                          pw.Text(
                            manager.managerState,
                            style: const pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
              pw.Footer(
                decoration: const pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFFca122e),
                ),
                title: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        '© SS ALUGUÉIS - Todos os direitos reservados',
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 12,
                        ),
                      ),
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
