import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../controller/agency_controller.dart';
import '../controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

/// CREATING THE STATE OF THE AGENCY REGISTRATION PAGE
class AgencyRegistrationState with ChangeNotifier {
  /// STATE BUILDER
  AgencyRegistrationState(int? id) {
    loadManager();
    init(id);
  }

  /// CHECK IF THE AGENCY WILL BE EDITED
  Future<void> init(int? id) async {
    if (id != null) {
      final agency = await controllerAgency.getAgencyById(id);
      populateForm(agency!);
    }
  }

  final TextEditingController _controllerAgencyName = TextEditingController();
  final TextEditingController _controllerAgencyPhone = TextEditingController();
  final TextEditingController _controllerAgencyCity = TextEditingController();
  final TextEditingController _controllerAgencyAddress =
      TextEditingController();
  final TextEditingController _controllerAgencyState = TextEditingController();
  final TextEditingController _controllerAgencyManager =
      TextEditingController();

  /// GET CONTROLLER AGENCY NAME
  TextEditingController get controllerAgencyName => _controllerAgencyName;

  /// GET CONTROLLER AGENCY PHONE
  TextEditingController get controllerAgencyPhone => _controllerAgencyPhone;

  /// GET CONTROLLER AGENCY CITY
  TextEditingController get controllerAgencyCity => _controllerAgencyCity;

  /// GET CONTROLLER AGENCY ADDRESS
  TextEditingController get controllerAgencyAddress => _controllerAgencyAddress;

  /// GET CONTROLLER AGENCY STATE
  TextEditingController get controllerAgencyState => _controllerAgencyState;

  /// GET CONTROLLER AGENCY MANAGER
  TextEditingController get controllerAgencyManager => _controllerAgencyManager;

  /// GET CONTROLLER AGENCY IN DATABASE
  final controllerAgency = AgencyController();

  /// SELECTED MANAGER IN DROPDOWN
  Manager? selectedManager;

  /// FUNCTION TO SET SELECTED MANAGER IN DROPDOWN
  void onManagerSelect(Manager manager) {
    selectedManager = manager;
    notifyListeners();
  }

  /// FUNCTION INSERT AGENCY IN DATABASE
  Future<void> insertAgency() async {
    final agency = Agency(
      agencyName: controllerAgencyName.text,
      agencyCity: controllerAgencyCity.text,
      agencyState: controllerAgencyState.text,
      agencyPhone: controllerAgencyPhone.text,
      managerCode: selectedManager!.managerId,
      agencyAddress: controllerAgencyAddress.text,
    );
    await controllerAgency.insert(agency);
    notifyListeners();
  }

  /// FORMAT THE PHONE TEXT FIELD
  MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) ####-####',
    type: MaskAutoCompletionType.eager,
  );

  final _listManager = <Manager>[];

  /// GET LIST MANAGER
  List<Manager> get listManager => _listManager;

  /// GET CONTROLLER MANAGER IN DATABASE
  final controllerManager = ManagerController();

  /// FUNCTION LOAD MANAGERS FROM DATABASE
  Future<void> loadManager() async {
    final list = await controllerManager.selectManager();
    _listManager.clear();
    _listManager.addAll(list);
    notifyListeners();
  }

  /// FUNCTION TO POPULATE THE FORM
  void populateForm(Agency agency) async {
    _controllerAgencyState.text = agency.agencyState;
    _controllerAgencyPhone.text = agency.agencyPhone;
    _controllerAgencyCity.text = agency.agencyCity;
    _controllerAgencyAddress.text = agency.agencyAddress;
    _controllerAgencyName.text = agency.agencyName;
    selectedManager =
        await controllerManager.getManagerById(agency.managerCode!);
    _controllerAgencyManager.text = selectedManager!.managerName;
    notifyListeners();
  }

  /// FUNCTION TO UPDATE AGENCY FROM DATABASE
  Future<void> updateAgency(Agency agency) async {
    agency = Agency(
      agencyName: controllerAgencyName.text,
      agencyCity: controllerAgencyCity.text,
      agencyState: controllerAgencyState.text,
      agencyPhone: controllerAgencyPhone.text,
      managerCode: selectedManager!.managerId,
      agencyAddress: controllerAgencyAddress.text,
      agencyId: agency.agencyId,
    );
    await controllerAgency.updateAgency(agency);
    notifyListeners();
  }
}
