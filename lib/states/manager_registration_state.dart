import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/agency_controller.dart';
import '../controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

class ManagerRegistrationState with ChangeNotifier {
  ManagerRegistrationState({this.manager}) {
    loadAgency();
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

  TextEditingController get controllerManagerPhone => _controllerManagerPhone;

  final ManagerController controllerManager = ManagerController();

  final Manager? manager;

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
    );

    await controllerManager.insert(manager);
    print('Insert concluído');
    notifyListeners();
  }

  final controllerAgency = AgencyController();
  final _listAgency = <Agency>[];

  List<Agency> get listAgency => _listAgency;

  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  Agency? _selectedItem;

  Agency? get selectedItem => _selectedItem;

  void onChangedDropdown(Agency? agency) {
    _selectedItem = agency;
    notifyListeners();
  }
}
