import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
  String rentalStats = 'nao retirado';
  String rentalPaymentStats = 'Pago';


  int differenceNowRentalEnd(DateTime rentalEnd) {
    Duration difference = rentalEnd.difference(DateTime.now());
    final differenceInDays = difference.inDays;

    return differenceInDays;
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
      rentalStats: rentalStats,
      rentalPaymentStats: rentalPaymentStats,
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

  String formattedDate(DateTime date) {
    DateTime formatted = date;
    String formattedDate = DateFormat('dd-MM-yyyy').format(formatted);

    return formattedDate;
  }

  MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) ####-####',
    type: MaskAutoCompletionType.eager,
  );

  String formatPhone(String phone) {
    phone = maskFormatterPhone
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: phone),
        )
        .text;

    return phone;
  }

  MaskTextInputFormatter maskFormatterMobilePhone = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    type: MaskAutoCompletionType.eager,
  );

  String formatMobilePhone(String phone) {
    phone = maskFormatterMobilePhone
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: phone),
        )
        .text;

    return phone;
  }

  Future<File> proofOfRental(
    Agency agency,
    String customerName,
    String customerCnpj,
    String vehicleModel,
    String vehicleBrand,
    List<String> images,
    DateTime pickUpDate,
    DateTime deliverDate,
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

              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Table(
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
                          'Cliente',
                          style: const pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          customerName.toUpperCase(),
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'CNPJ',
                          style: const pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          customerCnpj,
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Telefone',
                          style: const pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          customerPhone,
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Localidade',
                          style: const pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          '$customerCity / $customerState',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Detalhes da Locação:',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
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
                              'Emissão',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              formattedDateTimeNow(),
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Marca',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              vehicleBrand,
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Modelo',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              vehicleModel,
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Placa',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              vehiclePlate,
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Retirada',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              formattedDate(pickUpDate),
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Entrega',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              formattedDate(deliverDate),
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Valor da diária',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'R\$ ${dailyCost.toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Total de diárias',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '$totalDays dias',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ]),
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Valor Total',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'R\$ ${totalRent!.toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 14),
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
                              fontSize: 16,
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
                title: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(20),
                      width: 500,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      child: pw.Text(
                        '${agency.agencyName} - ${agency.agencyAddress} - Telefone: ${formatPhone(agency.agencyPhone)}',
                        style: const pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center,
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
            crossAxisAlignment: pw.CrossAxisAlignment.start,
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

              pw.SizedBox(height: 20),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Mais informações:',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Table(
                    border: pw.TableBorder.all(color: PdfColors.grey),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(220),
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              'Local da retirada',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '${agency.agencyAddress} - ${agency.agencyCity} / ${agency.agencyState}',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Gerente',
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            manager.managerName,
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Contato',
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            formatMobilePhone(manager.managerPhone),
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Email',
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            manager.managerEmail,
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
              pw.Expanded(
                child: pw.Container(),
              ),
              pw.Footer(
                title: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(20),
                      width: 500,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      child: pw.Text(
                        '${agency.agencyName} - ${agency.agencyAddress} - Telefone: ${formatPhone(agency.agencyPhone)}',
                        style: const pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center,
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

    return saveDocument(
        name: '${agency.agencyName.replaceAll(' ', '')}-${DateTime.now()}.pdf',
        pdf: pdf);
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
