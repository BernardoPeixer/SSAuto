import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ss_auto/model/customerModel.dart';
import 'package:ss_auto/model/managerModel.dart';
import 'package:ss_auto/model/vehicleModel.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'ssauto.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(CustomerTable.createTable);
      db.execute(VehicleTable.createTable);
      db.execute(ManagerTable.createTable);
    },
    version: 1,
  );
}


