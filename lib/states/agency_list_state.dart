import 'package:flutter/widgets.dart';
import 'package:ss_auto/controller/agency_controller.dart';
import 'package:ss_auto/controller/manager_controller.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

class AgencyListState with ChangeNotifier {
  AgencyListState() {
    loadAgency();
    loadManager();
  }

  final _listAgency = <Agency>[];
  final _listManager = <Manager>[];

  List<Agency> get listAgency => _listAgency;

  List<Manager> get listManager => _listManager;
  final controllerAgency = AgencyController();

  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  List<Manager> getManagersForAgency(int managerCode) {
    return _listManager
        .where((manager) => manager.managerId == managerCode)
        .toList();
  }

  Future<void> loadManager() async {
    final List<Manager> list = await controllerAgency.selectManager();
    _listManager.clear();
    _listManager.addAll(list);
    notifyListeners();
  }

  Future<void> deleteAgency(Agency agency) async {
    await controllerAgency.delete(agency);
    await loadAgency();
    notifyListeners();
  }
}
