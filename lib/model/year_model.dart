
/// VEHICLE YEAR MODEL
class Year {
  /// VEHICLE YEAR CONSTRUCTOR
  Year({
    required this.name,
    required this.code,
  });

  /// VEHICLE YEAR
  final String name;
  /// VEHICLE YEAR CODE
  final String? code;

  /// FUNCTION TO GET YEAR FROM FIPE API
  static Year fromJson(Map<String, dynamic> json) {
    return Year(
      name: json['name'],
      code: json['code'],
    );
  }
}
