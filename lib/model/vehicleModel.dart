class Vehicle {
  Vehicle({
    required this.brand,
    required this.model,
    required this.licensePlate,
    required this.year,
    required this.category,
    required this.dailyCost,
    required this.mileage,
    required this.color,
    required this.air,
    required this.sensor,
  });

  final String brand;
  final String model;
  final String licensePlate;
  final String year;
  final String category;
  final String dailyCost;
  final String mileage;
  final String color;
  final String air;
  final String sensor;
  late int? id;
}

class VehicleTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $brand        INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $model        TEXT NOT NULL,
      $licensePlate TEXT NOT NULL,
      $year         TEXT NOT NULL,
      $category     TEXT NOT NULL,
      $dailyCost    TEXT NOT NULL,
      $mileage      TEXT NOT NULL
    );
    ''';

  static const String tableName = 'vehicle';
  static const String id = 'id';
  static const String brand = 'brand';
  static const String model = 'model';
  static const String licensePlate = 'licensePlate';
  static const String year = 'year';
  static const String category = 'category';
  static const String dailyCost = 'dailyCost';
  static const String mileage = 'mileage';

  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehicleTable.brand] = vehicle.brand;
    map[VehicleTable.model] = vehicle.model;
    map[VehicleTable.licensePlate] = vehicle.licensePlate;
    map[VehicleTable.year] = vehicle.year;
    map[VehicleTable.category] = vehicle.category;
    map[VehicleTable.dailyCost] = vehicle.dailyCost;
    map[VehicleTable.mileage] = vehicle.mileage;

    return map;
  }
}
