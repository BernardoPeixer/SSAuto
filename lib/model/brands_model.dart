class Brands {
  String? code;
  final String? name;

  Brands({
    required this.code,
    required this.name,
  });

  static fromJson(Map<String, dynamic> json) {
    return Brands(
      code: json['code'],
      name: json['name'],
    );
  }
}
