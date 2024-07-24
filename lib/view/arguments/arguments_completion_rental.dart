/// COMPLETION RENTAL PAGE ARGUMENTS
class ArgumentsCompletionRental {
  /// RENTAL START ARGUMENTS
  final String rentalStart;

  /// RENTAL END ARGUMENTS
  final String rentalEnd;

  /// RENTAL START DATE TIME ARGUMENTS
  final DateTime rentalStartA;

  /// RENTAL END DATE TIME ARGUMENTS
  final DateTime rentalEndA;

  /// CUSTOMER ID
  final int customerId;

  /// VEHICLE ID
  final int vehicleId;

  /// IMAGES PATHS
  final List<String> listPaths;

  /// BUILDER
  ArgumentsCompletionRental({
    required this.vehicleId,
    required this.customerId,
    required this.listPaths,
    required this.rentalStart,
    required this.rentalStartA,
    required this.rentalEnd,
    required this.rentalEndA,
  });
}
