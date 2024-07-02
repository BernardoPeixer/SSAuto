import '../../model/vehicle_model.dart';

class CarArguments {
  final Vehicle vehicle;
  final List<String> imagePath;

  const CarArguments({
    required this.vehicle,
    required this.imagePath,
  });
}
