import 'package:flutter/widgets.dart';
import '../controller/agency_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

/// CREATING THE STATE OF THE AGENCY LIST PAGE
class AgencyListState with ChangeNotifier {
  /// BUILDER OF STATE
  AgencyListState() {
    loadAgency();
    loadManager();
  }

  final _listAgency = <Agency>[];
  final _listManager = <Manager>[];

  /// GETTER LIST AGENCYS
  List<Agency> get listAgency => _listAgency;

  /// GETTER LIST MANAGERS
  List<Manager> get listManager => _listManager;

  /// CONTROLLER AGENCY FOR DATABASE
  final controllerAgency = AgencyController();

  /// FUNCTION TO LOAD AGENCYS
  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  /// FUNCTION TO GET THE MANAGER BY AGENCY
  List<Manager> getManagersForAgency(int managerCode) {
    return _listManager
        .where((manager) => manager.managerId == managerCode)
        .toList();
  }

  /// FUNCTION TO LOAD MANAGERS
  Future<void> loadManager() async {
    final list = await controllerAgency.selectManager();
    _listManager.clear();
    _listManager.addAll(list);
    notifyListeners();
  }

  /// FUNCTION TO DELETE AGENCY
  Future<void> deleteAgency(Agency agency) async {
    await controllerAgency.delete(agency);
    await loadAgency();
    notifyListeners();
  }
}
