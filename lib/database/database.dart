import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ss_auto/model/customerModel.dart';
import 'package:ss_auto/model/managerModel.dart';
import 'package:ss_auto/model/vehicleModel.dart';

Future<Database> getDatabase() async {
  final String databasesPath = await getDatabasesPath();
  final String path = join(databasesPath, 'ssauto.db');

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(CustomerTable.createTable);
      await db.execute(VehicleTable.createTable);
      await db.execute(ManagerTable.createTable);
    },
    version: 1,
  );
}
