class ServiceItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl; // Main image for the service
  final List<String> workImages; // Additional images

  ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.workImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'workImages': workImages,
    };
  }

  factory ServiceItem.fromMap(Map<String, dynamic> map) {
    return ServiceItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      workImages: List<String>.from(map['workImages'] ?? []),
    );
  }
}
