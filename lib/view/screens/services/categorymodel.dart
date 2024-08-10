class ServiceCategory {
  final String id;
  final String name;

  ServiceCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ServiceCategory.fromMap(Map<String, dynamic> map) {
    return ServiceCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
