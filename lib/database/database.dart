import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ss_auto/model/agency_model.dart';
import 'package:ss_auto/model/customer_model.dart';
import 'package:ss_auto/model/manager_model.dart';
import 'package:ss_auto/model/rental_model.dart';
import 'package:ss_auto/model/vehicle_model.dart';

Future<Database> getDatabase() async {
  final String databasesPath = await getDatabasesPath();
  final String path = join(databasesPath, 'ssauto.db');

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
