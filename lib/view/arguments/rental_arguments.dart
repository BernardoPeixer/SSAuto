import '../../model/agency_model.dart';

class RentalArguments {
  final String rentalStart;
  final String rentalEnd;
  final Agency? selectedAgency;

  RentalArguments({
    required this.rentalStart,
    required this.rentalEnd,
    required this.selectedAgency,
  });
}
