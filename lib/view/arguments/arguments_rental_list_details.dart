/// ARGUMENTS RENTAL LIST DETAILS PAGE
class ArgumentsRentalListDetails {
  /// RENTAL ID
  final int rentId;

  /// IMAGE PATHS FROM VEHICLES
  final List<String> paths;

  /// BUILDER
  ArgumentsRentalListDetails({
    required this.paths,
    required this.rentId,
  });
}
