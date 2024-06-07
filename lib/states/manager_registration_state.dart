import 'package:flutter/cupertino.dart';
import '../controller/manager_controller.dart';
import '../model/manager_model.dart';

class ManagerRegistrationState with ChangeNotifier{

  ManagerRegistrationState({this.manager});

  final keyFormManager = GlobalKey<FormState>();

  final _controllerManagerName = TextEditingController();
  TextEditingController get controllerManagerName => _controllerManagerName;

  final _controllerManagerCity = TextEditingController();
  TextEditingController get controllerManagerCity => _controllerManagerCity;

  final _controllerManagerCpf = TextEditingController();
  TextEditingController get controllerManagerCpf => _controllerManagerCpf;

  final _controllerManagerState = TextEditingController();
  TextEditingController get controllerManagerState => _controllerManagerState;

  final _controllerManagerEmail = TextEditingController();
  TextEditingController get controllerManagerEmail => _controllerManagerEmail;

  final _controllerManagerPhone = TextEditingController();
  TextEditingController get controllerManagerPhone => _controllerManagerPhone;

  final controllerManager = ManagerController();

  final Manager? manager;

  Future<void> insertManager() async {
    print('chamando insert');
    final manager = Manager(
      name: controllerManagerName.text,
      city: controllerManagerCity.text,
      cpf:  controllerManagerCpf.text,
      state:controllerManagerState.text,
      email:controllerManagerEmail.text,
      phone:controllerManagerPhone.text,
    );
    await controllerManager.insert(manager);
    controllerManagerName.clear();
    controllerManagerCity.clear();
    controllerManagerCpf.clear();
    controllerManagerState.clear();
    controllerManagerEmail.clear();
    controllerManagerPhone.clear();
    notifyListeners();
    print('insert concluido');
  }

}