import 'package:flutter/cupertino.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import '../model/customer_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomerRegistrationState with ChangeNotifier {
  CustomerRegistrationState({this.customer});

  bool visible = false;

  final keyFormCustomer = GlobalKey<FormState>();

  final controllerCustomer = CustomerController();

  final TextEditingController _controllerCnpj = TextEditingController();

  TextEditingController get controllerCnpj => _controllerCnpj;

  final Customer? customer;

  String customerCompanyName = '';
  String customerCompanyCnpj = '';
  String customerCompanyPhone = '';
  String customerCompanyCity = '';
  String customerCompanyState = '';
  String customerCompanyActivity = '';

  // Future<void> insertCustomer() async {
  //   print('chamando insert');
  //   final customer = Customer(
  //     company: controllerCustomerCompany.text,
  //     city: controllerCustomerCity.text,
  //     cnpj: controllerCustomerCnpj.text,
  //     state: controllerCustomerState.text,
  //     email: controllerCustomerEmail.text,
  //     phone: controllerCustomerPhone.text,
  //     ati
  //   );
  //   await controllerCustomer.insert(customer);
  //   controllerCustomerCompany.clear();
  //   controllerCustomerCity.clear();
  //   controllerCustomerCnpj.clear();
  //   controllerCustomerState.clear();
  //   controllerCustomerEmail.clear();
  //   controllerCustomerPhone.clear();
  //   notifyListeners();
  //   print('insert concluido');
  // }

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
      final email = decoded['porte'];
      final phone = decoded['ddd_telefone_1'];
      final activity = decoded['descricao_situacao_cadastral'];

      return Customer(
          company: company,
          city: city,
          cnpj: cnpj,
          state: state,
          email: email,
          phone: phone,
          activity: activity);
    } catch (error) {
      return null;
    }
  }

  Future<void> setCompanyDetails() async {
    if (controllerCnpj.text.isNotEmpty) {
      final customerDetails = await getCompanyDetails(controllerCnpj.text);
      if (customerDetails != null) {
        visible = true;
        customerCompanyName = customerDetails.company ?? 'Não informado';
        customerCompanyPhone = customerDetails.phone ?? 'Não informado';
        customerCompanyCnpj = customerDetails.cnpj ?? 'Não informado';
        customerCompanyCity = customerDetails.city ?? 'Não informado';
        customerCompanyState = customerDetails.state ?? 'Não informado';
        customerCompanyActivity = customerDetails.activity ?? 'Não informado';
        controllerCnpj.clear();
      }
    }
    notifyListeners();
  }

  MaskTextInputFormatter maskFormatterCnpj = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    type: MaskAutoCompletionType.lazy,
  );
}
