import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/agency_model.dart';
import '../model/customer_model.dart';
import '../model/manager_model.dart';
import '../model/rental_model.dart';
import '../model/vehicle_model.dart';

/// FUNCTION TO OPEN DATABASE
Future<Database> getDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'ssauto.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(CustomerTable.createTable);
      await db.execute(VehicleTable.createTable);
      await db.execute(ManagerTable.createTable);
      await db.execute(RentalTable.createTable);
      await db.execute(AgencyTable.createTable);
    },
    version: 1,
  );
}
