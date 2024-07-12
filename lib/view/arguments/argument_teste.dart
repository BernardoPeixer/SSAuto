import 'package:ss_auto/model/rental_model.dart';
import '../../model/vehicle_model.dart';

class ArgumentTeste {
  final Rental rental;
  final Vehicle vehicle;
  final List<String> imagesPaths;

  ArgumentTeste({
    required this.rental,
    required this.vehicle,
    required this.imagesPaths,
  });
}
