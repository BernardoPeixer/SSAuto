import 'package:ss_auto/model/agency_model.dart';

class Vehicle {
  Vehicle({
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleLicensePlate,
    required this.vehicleYear,
    required this.vehicleDailyCost,
    required this.vehicleStats,
    this.vehicleId,
    required this.agencyCode,
  });

  final String vehicleBrand;
  final String vehicleModel;
  final String vehicleLicensePlate;
  final String vehicleYear;
  final double vehicleDailyCost;
  String vehicleStats;
  late int? vehicleId;
  int agencyCode;
}

class VehicleTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $vehicleId           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $vehicleBrand        TEXT NOT NULL,
      $vehicleModel        TEXT NOT NULL,
      $vehicleLicensePlate TEXT NOT NULL,
      $vehicleYear         TEXT NOT NULL,
      $vehicleDailyCost    DOUBLE NOT NULL,
      $vehicleStats        TEXT NOT NULL,
      $agencyCode          INTEGER NOT NULL,
      FOREIGN KEY($agencyCode) REFERENCES ${AgencyTable.tableName}(${AgencyTable.agencyId})
    );
    ''';

  static const String tableName = 'VehicleTable';
  static const String vehicleId = 'vehicleId';
  static const String vehicleBrand = 'vehicleBrand';
  static const String vehicleModel = 'vehicleModel';
  static const String vehicleLicensePlate = 'vehicleLicensePlate';
  static const String vehicleYear = 'vehicleYear';
  static const String vehicleDailyCost = 'vehicleDailyCost';
  static const String vehicleStats = 'vehicleStats';
  static const String agencyCode = 'agencyCode';

  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehicleTable.vehicleBrand] = vehicle.vehicleBrand;
    map[VehicleTable.vehicleModel] = vehicle.vehicleModel;
    map[VehicleTable.vehicleLicensePlate] = vehicle.vehicleLicensePlate;
    map[VehicleTable.vehicleYear] = vehicle.vehicleYear;
    map[VehicleTable.vehicleDailyCost] = vehicle.vehicleDailyCost;
    map[VehicleTable.agencyCode] = vehicle.agencyCode;
    map[VehicleTable.vehicleStats] = vehicle.vehicleStats;
    return map;
  }
}