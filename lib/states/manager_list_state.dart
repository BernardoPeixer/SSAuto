import 'package:flutter/material.dart';
import 'package:ss_auto/controller/manager_controller.dart';
import '../model/manager_model.dart';

class ManagerListState with ChangeNotifier {
  ManagerListState() {
    loadManager();
  }

  final _listManager = <Manager>[];

  List<Manager> get listManager => _listManager;

  final controllerManager = ManagerController();

  Future<void> loadManager() async {
    final list = await controllerManager.selectManager();

    _listManager.clear();
    _listManager.addAll(list);
    for (final manager in _listManager) {
      print('Nome: ${manager.name}, Telefone: ${manager.phone}, Cidade: ${manager.city}, Estado: ${manager.state}, Email: ${manager.email}, CPF: ${manager.cpf}');
    }
    notifyListeners();
  }
}
