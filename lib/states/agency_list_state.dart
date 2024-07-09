import 'package:flutter/widgets.dart';
import 'package:ss_auto/controller/agency_controller.dart';
import '../model/agency_model.dart';

class AgencyListState with ChangeNotifier {
  AgencyListState() {
    loadAgency();
  }

  final _listAgency = <Agency>[];

  List<Agency> get listAgency => _listAgency;
  final controllerAgency = AgencyController();

  Future<void> loadAgency() async {
    final list = await controllerAgency.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  Future<void> deleteAgency(Agency agency) async {
    await controllerAgency.delete(agency);
    await loadAgency();
    notifyListeners();
  }

}
