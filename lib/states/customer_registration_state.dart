import 'package:flutter/cupertino.dart';
import 'package:ss_auto/controller/customer_controller.dart';
import '../model/customer_model.dart';

class CustomerRegistrationState with ChangeNotifier {
  CustomerRegistrationState({this.customer});

  final keyFormCustomer = GlobalKey<FormState>();

  final _controllerCustomerName = TextEditingController();
  TextEditingController get controllerCustomerCompany => _controllerCustomerName;

  final _controllerCustomerCity = TextEditingController();
  TextEditingController get controllerCustomerCity => _controllerCustomerCity;

  final _controllerCustomerCnpj = TextEditingController();
  TextEditingController get controllerCustomerCnpj => _controllerCustomerCnpj;

  final _controllerCustomerState = TextEditingController();
  TextEditingController get controllerCustomerState => _controllerCustomerState;

  final _controllerCustomerEmail = TextEditingController();
  TextEditingController get controllerCustomerEmail=> _controllerCustomerEmail;

  final _controllerCustomerPhone= TextEditingController();
  TextEditingController get controllerCustomerPhone => _controllerCustomerPhone;

  final controllerCustomer = CustomerController();

  final Customer? customer;

  Future<void> insertCustomer() async {
    print('chamando insert');
    final customer = Customer(
      company: controllerCustomerCompany.text,
      city: controllerCustomerCity.text,
      cnpj:  controllerCustomerCnpj.text,
      state:controllerCustomerState.text,
      email:controllerCustomerEmail.text,
      phone:controllerCustomerPhone.text,
    );
    await controllerCustomer.insert(customer);
    controllerCustomerCompany.clear();
    controllerCustomerCity.clear();
    controllerCustomerCnpj.clear();
    controllerCustomerState.clear();
    controllerCustomerEmail.clear();
    controllerCustomerPhone.clear();
    notifyListeners();
    print('insert concluido');
  }
}
