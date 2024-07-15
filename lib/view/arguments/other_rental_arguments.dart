import '../../model/agency_model.dart';
import '../../model/customer_model.dart';
import '../../model/vehicle_model.dart';

/// CLASS RENTAL CUSTOMER VEHICLE ARGUMENTS TO ROUTE
class OtherRentalArguments {
  /// START RENTAL ARGUMENTS
  final String rentalStart;

  /// END RENTAL ARGUMENTS
  final String rentalEnd;

  /// START RENTAL DATE TIME ARGUMENTS
  final DateTime? rentalStartA;

  /// END RENTAL DATE TIME ARGUMENTS
  final DateTime? rentalEndA;

  /// AGENCY ARGUMENTS
  final Agency? selectedAgency;

  /// VEHICLE ARGUMENTS
  final Vehicle vehicle;

  /// VEHICLE IMAGES ARGUMENTS
  final List<String> imagePath;

  /// CUSTOMER ARGUMENTS
  final Customer customer;

  /// ARGUMENTS BUILDER
  OtherRentalArguments({
    required this.rentalStart,
    required this.rentalEnd,
    required this.rentalStartA,
    required this.rentalEndA,
    required this.selectedAgency,
    required this.vehicle,
    required this.imagePath,
    required this.customer,
  });
}
