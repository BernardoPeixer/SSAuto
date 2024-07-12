import 'package:ss_auto/model/agency_model.dart';
import 'package:ss_auto/model/customer_model.dart';
import 'package:ss_auto/model/vehicle_model.dart';

class Rental {
  Rental({
    this.rentalId,
    this.customerCode,
    this.agencyCode,
    this.vehicleCode,
    required this.rentalRegisterDate,
    required this.rentalStart,
    required this.rentalEnd,
    required this.rentalCost,
    required this.rentalStats,
    required this.rentalPaymentStats,
  });

  late int? rentalId;
  int? customerCode;
  int? agencyCode;
  int? vehicleCode;
  final String rentalRegisterDate;
  final String rentalStart;
  final String rentalEnd;
  final double rentalCost;
  String rentalStats;
  final String rentalPaymentStats;
}

class RentalTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $rentalId                  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerCode              INTEGER NOT NULL,
      $agencyCode                INTEGER NOT NULL,
      $vehicleCode               INTEGER NOT NULL,
      $rentalRegisterDate        TEXT NOT NULL,
      $rentalStart               TEXT NOT NULL,
      $rentalEnd                 TEXT NOT NULL,
      $rentalCost                DOUBLE NOT NULL,
      $rentalStats               TEXT NOT NULL,
      $rentalPaymentStats        TEXT NOT NULL,
      FOREIGN KEY($customerCode) REFERENCES ${CustomerTable.tableName}(${CustomerTable.customerId}),
      FOREIGN KEY($agencyCode)   REFERENCES ${AgencyTable.tableName}(${AgencyTable.agencyId}),
      FOREIGN KEY($vehicleCode)  REFERENCES ${VehicleTable.tableName}(${VehicleTable.vehicleId})
    );
    ''';

  static const String tableName = 'RentalTable';
  static const String rentalId = 'rentalId';
  static const String customerCode = 'customerCode';
  static const String agencyCode = 'agencyCode';
  static const String vehicleCode = 'vehicleCode';
  static const String rentalRegisterDate = 'rentalRegisterDate';
  static const String rentalStart = 'rentalStart';
  static const String rentalEnd = 'rentalEnd';
  static const String rentalCost = 'rentalCost';
  static const String rentalStats = 'rentalStats';
  static const String rentalPaymentStats = 'rentalPaymentStats';

  static Map<String, dynamic> toMap(Rental rental) {
    final map = <String, dynamic>{};

    map[RentalTable.customerCode] = rental.customerCode;
    map[RentalTable.agencyCode] = rental.agencyCode;
    map[RentalTable.vehicleCode] = rental.vehicleCode;
    map[RentalTable.rentalRegisterDate] = rental.rentalRegisterDate;
    map[RentalTable.rentalStart] = rental.rentalStart;
    map[RentalTable.rentalEnd] = rental.rentalEnd;
    map[RentalTable.rentalCost] = rental.rentalCost;
    map[RentalTable.rentalStats] = rental.rentalStats;
    map[RentalTable.rentalPaymentStats] = rental.rentalPaymentStats;
    return map;
  }
}
