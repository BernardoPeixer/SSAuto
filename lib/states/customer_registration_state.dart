import 'package:flutter/cupertino.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import '../model/customer_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomerRegistrationState with ChangeNotifier {
  CustomerRegistrationState({this.customer}) {
    loadCustomers();
  }

  bool visible = false;

  final keyFormCustomer = GlobalKey<FormState>();

  final controllerCustomer = CustomerController();

  final TextEditingController _controllerCnpj = TextEditingController();

  TextEditingController get controllerCnpj => _controllerCnpj;

  final Customer? customer;

  final _customerList = <Customer>[];

  List<Customer> get customerList => _customerList;

  String customerCompanyName = '';
  String customerCompanyCnpj = '';
  String customerCompanyPhone = '';
  String customerCompanyCity = '';
  String customerCompanyState = '';
  String customerCompanyActivity = '';

  bool? isValid;

  Future<void> insertCustomer() async {
    print('chamando insert');
    final customer = Customer(
      company: customerCompanyName,
      city: customerCompanyCity,
      cnpj: customerCompanyCnpj,
      state: customerCompanyState,
      phone: customerCompanyPhone,
      activity: customerCompanyActivity,
    );
    await controllerCustomer.insert(customer);
    customerList.add(customer);
    notifyListeners();
    print('insert concluido');
  }

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
          company: company,
          city: city,
          cnpj: cnpj,
          state: state,
          phone: phone,
          activity: activity);
    } catch (error) {
      return null;
    }
  }

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

  Future<void> setCompanyDetails() async {
    if (controllerCnpj.text.isNotEmpty) {
      final customerDetails = await getCompanyDetails(controllerCnpj.text);
      if (customerDetails != null) {
        visible = true;
        customerCompanyName = customerDetails.company;
        customerCompanyPhone = customerDetails.phone;
        customerCompanyCnpj = customerDetails.cnpj;
        customerCompanyCity = customerDetails.city;
        customerCompanyState = customerDetails.state;
        customerCompanyActivity = customerDetails.activity;
        controllerCnpj.clear();
      }
    }
    notifyListeners();
  }

  Future<void> loadCustomers() async {
    final list = await controllerCustomer.selectCustomers();

    _customerList.clear();
    _customerList.addAll(list);

    notifyListeners();
  }

  MaskTextInputFormatter maskFormatterCnpj = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    type: MaskAutoCompletionType.eager,
  );
}
