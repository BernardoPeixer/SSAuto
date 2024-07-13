import 'package:flutter/material.dart';

import '../controller/agency_controller.dart';
import '../controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

/// CREATING THE STATE OF THE AGENCY REGISTRATION PAGE
class AgencyRegistrationState with ChangeNotifier {
  /// STATE BUILDER
  AgencyRegistrationState() {
    loadManager();
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

  /// INSTANCE OF AGENCY
  Agency? agency;

  /// FUNCTION TO POPULATE THE FORM
// void populateForm(Agency agency) {
//   _controllerAgencyName.text = agency.agencyName;
//   _controllerAgencyManager.text = selectedManager?.managerName ?? '';
//   _controllerAgencyAddress.text = agency.agencyAddress;
//   _controllerAgencyCity.text = agency.agencyCity;
//   _controllerAgencyPhone.text = agency.agencyPhone;
//   _controllerAgencyState.text = agency.agencyState;
//   agency = Agency(
//     agencyName: agency.agencyName,
//     agencyCity: agency.agencyCity,
//     agencyAddress: agency.agencyAddress,
//     agencyPhone: agency.agencyPhone,
//     agencyState: agency.agencyState,
//     agencyId: agency.agencyId,
//     managerCode: agency.managerCode,
//   );
// }
}
