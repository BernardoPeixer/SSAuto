class Models {
  final String code;
  final String name;

  Models({
    required this.code,
    required this.name,
  });

  factory Models.fromJson(Map<String, dynamic> json) {
    return Models(
      code: json['code'],
      name: json['name'],
    );
  }
}
