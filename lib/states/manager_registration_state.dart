import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/manager_controller.dart';
import '../model/manager_model.dart';

/// CREATING THE STATE OF THE MANAGERS REGISTRATION PAGE
class ManagerRegistrationState with ChangeNotifier {
  /// BUILDER FOR STATE
  ManagerRegistrationState(int? id) {
    init(id);
  }

  /// FUNCTION WHEN INIT PAGE
  void init(int? id) async {
    if (id != null) {
      final manager = await controllerManager.getManagerById(id);
      populateForm(manager!);
    }
  }

  /// KEY FORM
  final GlobalKey<FormState> keyFormManager = GlobalKey<FormState>();

  final TextEditingController _controllerManagerName = TextEditingController();

  /// GET CONTROLLER MANAGER NAME
  TextEditingController get controllerManagerName => _controllerManagerName;

  final TextEditingController _controllerManagerCity = TextEditingController();

  /// GET CONTROLLER MANAGER CITY
  TextEditingController get controllerManagerCity => _controllerManagerCity;

  final TextEditingController _controllerManagerCpf = TextEditingController();

  /// GET CONTROLLER MANAGER CPF
  TextEditingController get controllerManagerCpf => _controllerManagerCpf;

  final TextEditingController _controllerManagerState = TextEditingController();

  /// GET CONTROLLER MANAGER STATE
  TextEditingController get controllerManagerState => _controllerManagerState;

  final TextEditingController _controllerManagerEmail = TextEditingController();

  /// GET CONTROLLER MANAGER EMAIL
  TextEditingController get controllerManagerEmail => _controllerManagerEmail;

  final TextEditingController _controllerManagerPhone = TextEditingController();

  /// GET CONTROLLER MANAGER PHONE
  TextEditingController get controllerManagerPhone => _controllerManagerPhone;

  final TextEditingController _controllerManagerCommission =
      TextEditingController();

  /// GET CONTROLLER MANAGER COMMISSION
  TextEditingController get controllerManagerCommission =>
      _controllerManagerCommission;

  /// GET CONTROLLER MANAGER IN DATABASE
  final ManagerController controllerManager = ManagerController();

  /// FORMATTER CPF FIELD
  MaskTextInputFormatter maskFormatterCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    type: MaskAutoCompletionType.eager,
  );

  /// FORMATTER PHONE TEXT FIELD
  MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    type: MaskAutoCompletionType.eager,
  );

  /// FUNCTION INSERT MANAGER IN DATABASE
  Future<void> insertManager() async {
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
    notifyListeners();
  }

  /// FUNCTION TO POPULATE THE FORM
  void populateForm(Manager manager) {
    _controllerManagerCity.text = manager.managerCity;
    _controllerManagerCommission.text = manager.managerCommission.toString();
    _controllerManagerCpf.text = manager.managerCpf;
    _controllerManagerEmail.text = manager.managerEmail;
    _controllerManagerName.text = manager.managerName;
    _controllerManagerPhone.text = manager.managerPhone;
    _controllerManagerState.text = manager.managerState;
    notifyListeners();
  }

  /// FUNCTION TO UPDATE MANAGER
  Future<void> updateManager(Manager manager) async {
    manager = Manager(
      managerId: manager.managerId,
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
