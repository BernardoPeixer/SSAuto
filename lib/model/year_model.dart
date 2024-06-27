class Year {
  Year({
    required this.name,
  });

  final String name;

  static fromJson(Map<String, dynamic> json) {
    return Year(
      name: json['name'],
    );
  }
}
