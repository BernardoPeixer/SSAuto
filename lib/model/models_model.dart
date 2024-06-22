class Models {
  final String code;
  final String name;

  Models({
    required this.code,
    required this.name,
  });

  static fromJson(Map<String, dynamic> json) {
    return Models(
      code: json['code'],
      name: json['name'],
    );
  }
}
