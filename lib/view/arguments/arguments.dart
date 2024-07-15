import 'package:ss_auto/model/rental_model.dart';
import '../../model/vehicle_model.dart';

/// CLASS ARGUMENTS TO ROUTES
class Arguments {
  /// RENTAL ARGUMENT
  final Rental rental;

  /// VEHICLE ARGUMENT
  final Vehicle vehicle;

  /// IMAGES PATH ARGUMENT
  final List<String> imagesPaths;

  /// ARGUMENTS BUILDER
  Arguments({
    required this.rental,
    required this.vehicle,
    required this.imagesPaths,
  });
}
