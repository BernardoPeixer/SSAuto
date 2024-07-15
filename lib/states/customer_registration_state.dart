import 'package:flutter/cupertino.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import '../model/customer_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// CREATING THE STATE OF THE CUSTOMER LIST PAGE
class CustomerRegistrationState with ChangeNotifier {
  /// STATE BUILDER
  CustomerRegistrationState({this.customer}) {
    loadCustomers();
  }

  /// BOOL TO SHOW THE CUSTOMER INFORMATION
  bool visible = false;

  /// KEY FORM
  final keyFormCustomer = GlobalKey<FormState>();

  /// CUSTOMER CONTROLLER FROM DATABASE
  final controllerCustomer = CustomerController();

  final TextEditingController _controllerCnpj = TextEditingController();

  /// GETTER CNPJ CONTROLLER
  TextEditingController get controllerCnpj => _controllerCnpj;

  /// INSTANCE OF CUSTOMER
  final Customer? customer;

  final _customerList = <Customer>[];

  /// GETTER CUSTOMER LIST
  List<Customer> get customerList => _customerList;

  /// CUSTOMER NAME
  String customerCompanyName = '';
  /// CUSTOMER CNPJ
  String customerCompanyCnpj = '';
  /// CUSTOMER PHONE
  String customerCompanyPhone = '';
  /// CUSTOMER CITY
  String customerCompanyCity = '';
  /// CUSTOMER STATE
  String customerCompanyState = '';
  /// CUSTOMER ACTIVITY
  String customerCompanyActivity = '';

  /// BOOL TO CHECK IF CNPJ IS VALID
  bool? isValid;

  /// FUNCTION TO INSERT CUSTOMER IN DATABASE
  Future<void> insertCustomer() async {
    print('chamando insert');
    final customer = Customer(
      customerName: customerCompanyName,
      customerCity: customerCompanyCity,
      customerCnpj: customerCompanyCnpj,
      customerState: customerCompanyState,
      customerPhone: customerCompanyPhone,
      customerStats: customerCompanyActivity,
    );
    await controllerCustomer.insert(customer);
    customerList.add(customer);
    notifyListeners();
    print('insert concluido');
  }

  /// FUNCTION TO GET COMPANY DETAILS FROM BRASIL API
  Future<Customer?> getCompanyDetails(String cnpj) async {
    try {
      final unmaskedCnpj = maskFormatterCnpj.getUnmaskedText();
      controllerCnpj.text = unmaskedCnpj;
      final response = await http.get(
        Uri.parse(
            'https://brasilapi.com.br/api/cnpj/v1/${controllerCnpj.text}'),
        headers: {},
      );
      final decoded = jsonDecode(response.body);

      final company = decoded['nome_fantasia'];
      final cnpj = decoded['cnpj'];
      final city = decoded['municipio'];
      final state = decoded['uf'];
      final phone = decoded['ddd_telefone_1'];
      final activity = decoded['descricao_situacao_cadastral'];

      return Customer(
          customerName: company,
          customerCity: city,
          customerCnpj: cnpj,
          customerState: state,
          customerPhone: phone,
          customerStats: activity);
    } catch (error) {
      return null;
    }
  }

  /// CHECK IF CNPJ IS VALID
  Future<void> validatorCnpj() async {
    final companyDetails = await getCompanyDetails(controllerCnpj.text);
    if (companyDetails == null) {
      isValid = false;
      controllerCnpj.clear();
    } else {
      isValid = true;
      await setCompanyDetails();
    }
    notifyListeners();
  }

  /// SET CUSTOMER INFORMATION
  Future<void> setCompanyDetails() async {
    if (controllerCnpj.text.isNotEmpty) {
      final customerDetails = await getCompanyDetails(controllerCnpj.text);
      if (customerDetails != null) {
        visible = true;
        customerCompanyName = customerDetails.customerName;
        customerCompanyPhone = customerDetails.customerPhone;
        customerCompanyCnpj = customerDetails.customerCnpj;
        customerCompanyCity = customerDetails.customerCity;
        customerCompanyState = customerDetails.customerState;
        customerCompanyActivity = customerDetails.customerStats;
        controllerCnpj.clear();
      }
    }
    notifyListeners();
  }

  /// LOAD CUSTOMERS FROM DATABASE
  Future<void> loadCustomers() async {
    final list = await controllerCustomer.selectCustomers();

    _customerList.clear();
    _customerList.addAll(list);

    notifyListeners();
  }

  /// MASK CNPJ TEXT
  MaskTextInputFormatter maskFormatterCnpj = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    type: MaskAutoCompletionType.eager,
  );

  /// MASK PHONE TEXT
  MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) ####-####',
    type: MaskAutoCompletionType.eager,
  );

  /// FUNCTION TO FORMAT CNPJ
  String formatCnpj() {
    customerCompanyCnpj = maskFormatterCnpj
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: customerCompanyCnpj),
        )
        .text;

    return customerCompanyCnpj;
  }

  /// FUNCTION TO FORMAT PHONE
  String formatPhone() {
    customerCompanyPhone = maskFormatterPhone.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: customerCompanyPhone),
    ).text;

    return customerCompanyPhone;
  }
}
