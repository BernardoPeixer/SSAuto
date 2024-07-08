import 'package:ss_auto/model/rental_model.dart';

import '../../model/agency_model.dart';
import '../../model/customer_model.dart';

class RentalArguments {
  final String rentalStart;
  final String rentalEnd;
  final DateTime rentalStartA;
  final DateTime rentalEndA;
  final Agency? selectedAgency;
  final Customer customer;

  RentalArguments({
    required this.rentalStart,
    required this.rentalStartA,
    required this.rentalEnd,
    required this.rentalEndA,
    required this.selectedAgency,
    required this.customer,
  });
}
