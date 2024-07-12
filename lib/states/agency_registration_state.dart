import 'package:flutter/material.dart';
import 'package:ss_auto/controller/agency_controller.dart';

import '../controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

class AgencyRegistrationState with ChangeNotifier {

  AgencyRegistrationState() {
    loadManager();
  }

  final TextEditingController _controllerAgencyName = TextEditingController();
  final TextEditingController _controllerAgencyPhone = TextEditingController();
  final TextEditingController _controllerAgencyCity = TextEditingController();
  final TextEditingController _controllerAgencyAddress = TextEditingController();
  final TextEditingController _controllerAgencyState = TextEditingController();
  final TextEditingController _controllerAgencyManager =
      TextEditingController();

  TextEditingController get controllerAgencyName => _controllerAgencyName;

  TextEditingController get controllerAgencyPhone => _controllerAgencyPhone;

  TextEditingController get controllerAgencyCity => _controllerAgencyCity;

  TextEditingController get controllerAgencyAddress => _controllerAgencyAddress;

  TextEditingController get controllerAgencyState => _controllerAgencyState;

  TextEditingController get controllerAgencyManager => _controllerAgencyManager;

  final controllerAgency = AgencyController();

  Manager? selectedManager;

  void onManagerSelect(Manager manager) {
    selectedManager = manager;
    notifyListeners();
  }

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
    print('insert concluido');
  }

  final _listManager = <Manager>[];

  List<Manager> get listManager => _listManager;

  final controllerManager = ManagerController();

  Future<void> loadManager() async {
    final list = await controllerManager.selectManager();
    _listManager.clear();
    _listManager.addAll(list);
    notifyListeners();
  }
}
