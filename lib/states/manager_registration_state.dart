import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/agency_controller.dart';
import '../controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

class ManagerRegistrationState with ChangeNotifier {

  ManagerRegistrationState(int? id, Manager manager) {
    init(id, manager);
  }

  void init(int? id, Manager manager) {
    if (id == null) {
      return;
    } else {
     populateForm(manager);
    }
  }

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
  final TextEditingController _controllerManagerCommission =
      TextEditingController();

  TextEditingController get controllerManagerPhone => _controllerManagerPhone;

  TextEditingController get controllerManagerCommission =>
      _controllerManagerCommission;

  final ManagerController controllerManager = ManagerController();

  MaskTextInputFormatter maskFormatterCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    type: MaskAutoCompletionType.eager,
  );

  Future<void> insertManager() async {
    print('Chamando insertManager');
    final manager = Manager(
      managerName: controllerManagerName.text,
      managerCity: controllerManagerCity.text,
      managerCpf: controllerManagerCpf.text,
      managerState: controllerManagerState.text,
      managerPhone: controllerManagerPhone.text,
      managerCommission: int.parse(controllerManagerCommission.text),
      managerEmail: controllerManagerEmail.text,
    );

    await controllerManager.insert(manager);
    print('Insert concluído');
    notifyListeners();
  }

  Future<void> populateForm(Manager manager) async {
    _controllerManagerCity.text = manager.managerCity;
    _controllerManagerCommission.text = manager.managerCommission.toString();
    _controllerManagerCpf.text = manager.managerCpf;
    _controllerManagerEmail.text = manager.managerEmail;
    _controllerManagerName.text = manager.managerName;
    _controllerManagerPhone.text = manager.managerPhone;
    _controllerManagerState.text = manager.managerState;
    notifyListeners();
  }

  Future<void> updateManager() async {
    final manager = Manager(
      managerName: controllerManagerName.text,
      managerCity: controllerManagerCity.text,
      managerCpf: controllerManagerCpf.text,
      managerState: controllerManagerState.text,
      managerPhone: controllerManagerPhone.text,
      managerCommission: int.parse(controllerManagerCommission.text),
      managerEmail: controllerManagerEmail.text,
    );
    await controllerManager.updateManager(manager);
    notifyListeners();
  }
}
