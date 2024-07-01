import 'package:flutter/cupertino.dart';
import '../controller/agency_controller.dart';
import '../model/agency_model.dart';

class CarRentFilterState with ChangeNotifier {

  CarRentFilterState() {
    loadAgency();
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

  Agency? selectedAgency;

  void onPressedAgency (Agency? agency) {
    selectedAgency = agency;
    notifyListeners();
  }
}