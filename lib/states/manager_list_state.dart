import 'package:flutter/material.dart';
import '../controller/manager_controller.dart';
import '../model/manager_model.dart';

/// CREATING THE STATE OF THE MANAGERS LIST PAGE
class ManagerListState with ChangeNotifier {
  /// STATE BUILDER
  ManagerListState() {
    loadManager();
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

}
