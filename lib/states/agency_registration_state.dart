import 'package:flutter/material.dart';
import 'package:ss_auto/controller/agency_controller.dart';

import '../model/agency_model.dart';

class AgencyRegistrationState with ChangeNotifier {
  final TextEditingController _controllerAgencyName = TextEditingController();
  final TextEditingController _controllerAgencyCity = TextEditingController();
  final TextEditingController _controllerAgencyState = TextEditingController();
  TextEditingController get controllerAgencyName => _controllerAgencyName;
  TextEditingController get controllerAgencyCity => _controllerAgencyCity;
  TextEditingController get controllerAgencyState => _controllerAgencyState;

  final controllerAgency = AgencyController();

  Future<void> insertAgency() async {
    final agency = Agency(
      agencyName: controllerAgencyName.text,
      agencyCity: controllerAgencyCity.text,
      agencyState: controllerAgencyState.text,
    );
    await controllerAgency.insert(agency);
    notifyListeners();
    print('insert concluido');
  }
}