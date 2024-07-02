import 'package:ss_auto/model/rental_model.dart';
import '../database/database.dart';

class RentalController {
  Future<void> insert(Rental vehicle) async {
    final database = await getDatabase();
    final map = RentalTable.toMap(vehicle);

    await database.insert(RentalTable.tableName, map);

    return;
  }


}