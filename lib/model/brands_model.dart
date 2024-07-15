
/// CAR BRANDS MODEL
class Brands {
  /// CODE FROM BRANDS
  String? code;
  /// NAME FROM BRANDS
  final String? name;

  /// CONSTRUCTOR BRANDS
  Brands({
    required this.code,
    required this.name,
  });

  /// FUNCTION TO GET BRANDS FROM FIPE API
  static Brands fromJson(Map<String, dynamic> json) {
    return Brands(
      code: json['code'],
      name: json['name'],
    );
  }
}
