class VendorDetails {
  final String name;
  final String address;
  final String contact;
  final String imageUrl;
  final List<String> workImages;

  VendorDetails({
    required this.name,
    required this.address,
    required this.contact,
    required this.imageUrl,
    required this.workImages,
  });

  factory VendorDetails.fromFirestore(Map<String, dynamic> data) {
    return VendorDetails(
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      contact: data['contact'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      workImages: (data['workImages'] ?? []).cast<String>(), // Ensure workImages is a list of strings
    );
  }
}




