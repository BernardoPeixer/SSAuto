/// ARGUMENTS RENTAL FILTERS PAGE
class ArgumentsRentalFilters {
  /// RENTAL START ARGUMENTS
  final String rentalStart;

  /// RENTAL END ARGUMENTS
  final String rentalEnd;

  /// RENTAL START DATE TIME ARGUMENTS
  final DateTime rentalStartA;

  /// RENTAL END DATE TIME ARGUMENTS
  final DateTime rentalEndA;

  /// AGENCY ID ARGUMENTS
  final int agencyId;

  /// CUSTOMER ID ARGUMENTS
  final int customerId;

  /// BUILDER
  ArgumentsRentalFilters({
    required this.agencyId,
    required this.rentalStart,
    required this.customerId,
    required this.rentalStartA,
    required this.rentalEndA,
    required this.rentalEnd,
  });
}
