class Vehicle {
  Vehicle({
    required this.brand,
    required this.model,
    required this.licensePlate,
    required this.year,
    required this.dailyCost,
    this.id,
  });

  final String brand;
  final String model;
  final String licensePlate;
  final String year;
  final String dailyCost;
  late int? id;


}

class VehicleTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $brand        TEXT NOT NULL,
      $model        TEXT NOT NULL,
      $licensePlate TEXT NOT NULL,
      $year         TEXT NOT NULL,
      $dailyCost    TEXT NOT NULL
    );
    ''';

  static const String tableName = 'vehicle';
  static const String id = 'id';
  static const String brand = 'brand';
  static const String model = 'model';
  static const String licensePlate = 'licensePlate';
  static const String year = 'year';
  static const String dailyCost = 'dailyCost';

  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehicleTable.brand] = vehicle.brand;
    map[VehicleTable.model] = vehicle.model;
    map[VehicleTable.licensePlate] = vehicle.licensePlate;
    map[VehicleTable.year] = vehicle.year;
    map[VehicleTable.dailyCost] = vehicle.dailyCost;

    return map;
  }
}
