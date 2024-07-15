
/// BAR CHART MODEL
class ChartModel {
  /// MONTH NAME
  final String month;
  /// INDEX REPRESENTING MONTH POSITION
  final int index;
  /// TOTAL PER MONTH
  final double? total;

  /// CONSTRUCTOR BAR CHART MODEL
  ChartModel({
    required this.month,
    required this.total,
    required this.index,
  });
}
