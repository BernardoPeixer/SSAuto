import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/agency_controller.dart';
import '../controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

/// CREATING THE STATE OF THE MANAGERS REGISTRATION PAGE
class ManagerRegistrationState with ChangeNotifier {
  /// STATE BUILDER
  ManagerRegistrationState() {
    loadAgency();
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

  /// MANAGER INSTANCE
  Manager? manager;

  /// FORMATTER TEXT FIELD CPF
  MaskTextInputFormatter maskFormatterCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    type: MaskAutoCompletionType.eager,
  );

  /// FUNCTION INSERT MANAGER IN DATABASE
  Future<void> insertManager() async {
    manager = Manager(
      managerName: controllerManagerName.text,
      managerCity: controllerManagerCity.text,
      managerCpf: controllerManagerCpf.text,
      managerState: controllerManagerState.text,
      managerPhone: controllerManagerPhone.text,
      managerCommission: int.parse(controllerManagerCommission.text),
      managerEmail: controllerManagerEmail.text,
    );

    await controllerManager.insert(manager!);
    notifyListeners();
  }

  final _controllerAgency = AgencyController();
  final _listAgency = <Agency>[];

  /// GET LIST AGENCY
  List<Agency> get listAgency => _listAgency;

  /// FUNCTION LOAD AGENCIES FROM DATABASE
  Future<void> loadAgency() async {
    final list = await _controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  Agency? _selectedItem;

  /// GET SELECTED ITEM
  Agency? get selectedItem => _selectedItem;

  /// FUNCTION TO SET THE SELECTED ITEM IN DROPDOWN
  void onChangedDropdown(Agency? agency) {
    _selectedItem = agency;
    notifyListeners();
  }


  /// FUNCTION TO POPULATE THE FORM
// void populateForm(Manager manager) {
//   _controllerManagerName.text = manager.managerName;
//   _controllerManagerEmail.text = manager.managerEmail;
//   _controllerManagerCommission.text =
//       manager.managerCommission.toString();
//   _controllerManagerPhone.text = manager.managerPhone;
//   _controllerManagerCpf.text = manager.managerCpf;
//   _controllerManagerState.text = manager.managerState;
//   _controllerManagerCity.text = manager.managerCity;
//
//   manager = Manager(
//       managerName: manager.managerName,
//       managerCity: manager.managerCity,
//       managerCpf: manager.managerCpf,
//       managerState: manager.managerState,
//       managerPhone: manager.managerPhone,
//       managerCommission: manager.managerCommission,
//       managerEmail: manager.managerEmail,
//   );
// }
}
