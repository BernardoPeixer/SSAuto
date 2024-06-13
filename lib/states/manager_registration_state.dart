import 'package:flutter/material.dart';
import '../controller/manager_controller.dart';
import '../model/manager_model.dart';

class ManagerRegistrationState with ChangeNotifier {
  ManagerRegistrationState({this.manager});

  final GlobalKey<FormState> keyFormManager = GlobalKey<FormState>();

  final TextEditingController _controllerManagerName = TextEditingController();
  TextEditingController get controllerManagerName => _controllerManagerName;

  final TextEditingController _controllerManagerCity = TextEditingController();
  TextEditingController get controllerManagerCity => _controllerManagerCity;

  final TextEditingController _controllerManagerCpf = TextEditingController();
  TextEditingController get controllerManagerCpf => _controllerManagerCpf;

  final TextEditingController _controllerManagerState = TextEditingController();
  TextEditingController get controllerManagerState => _controllerManagerState;

  final TextEditingController _controllerManagerEmail = TextEditingController();
  TextEditingController get controllerManagerEmail => _controllerManagerEmail;

  final TextEditingController _controllerManagerPhone = TextEditingController();
  TextEditingController get controllerManagerPhone => _controllerManagerPhone;

  final ManagerController controllerManager = ManagerController();

  final Manager? manager;

  Future<void> insertManager() async {
    print('Chamando insertManager');
    final manager = Manager(
      name: controllerManagerName.text,
      city: controllerManagerCity.text,
      cpf:  controllerManagerCpf.text,
      state: controllerManagerState.text,
      email: controllerManagerEmail.text,
      phone: controllerManagerPhone.text,
    );

    await controllerManager.insert(manager);
    print('Insert concluído');
    notifyListeners();
  }
}
