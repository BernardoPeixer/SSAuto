class Brands {
  final String code;
  final String? name;

  Brands({
    required this.code,
    required this.name,
  });

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      code: json['code'],
      name: json['name'],
    );
  }
}
