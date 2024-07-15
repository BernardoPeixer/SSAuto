
/// CAR MODELS MODEL
class Models {
  /// CODE OF MODEL
  final String code;
  /// NAME OF MODEL
  final String name;

  /// CONSTRUCTOR CAR MODELS
  Models({
    required this.code,
    required this.name,
  });

  /// FUNCTION TO GET MODELS FROM FIPE API
  static Models fromJson(Map<String, dynamic> json) {
    return Models(
      code: json['code'],
      name: json['name'],
    );
  }
}
