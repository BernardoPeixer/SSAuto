import '../../model/agency_model.dart';
import '../../model/customer_model.dart';
import '../../model/vehicle_model.dart';

class OtherRentalArguments {
  final String rentalStart;
  final String rentalEnd;
  final DateTime? rentalStartA;
  final DateTime? rentalEndA;
  final Agency? selectedAgency;
  final Vehicle vehicle;
  final List<String> imagePath;
  final Customer customer;

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
