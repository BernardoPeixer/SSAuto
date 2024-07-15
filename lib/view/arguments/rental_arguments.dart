import '../../model/agency_model.dart';
import '../../model/customer_model.dart';

/// RENTAL CUSTOMER AGENCY ARGUMENTS TO ROUTE
class RentalArguments {
  /// RENTAL START ARGUMENTS
  final String rentalStart;

  /// RENTAL END ARGUMENTS
  final String rentalEnd;

  /// RENTAL START DATE TIME ARGUMENTS
  final DateTime rentalStartA;

  /// RENTAL END DATE TIME ARGUMENTS
  final DateTime rentalEndA;

  /// AGENCY ARGUMENTS
  final Agency? selectedAgency;

  /// CUSTOMER ARGUMENTS
  final Customer customer;

  /// ARGUMENTS BUILDER
  RentalArguments({
    required this.rentalStart,
    required this.rentalStartA,
    required this.rentalEnd,
    required this.rentalEndA,
    required this.selectedAgency,
    required this.customer,
  });
}
