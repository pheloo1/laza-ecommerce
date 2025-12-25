class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  // Helper: safely convert anything to double
  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0.0;
    return 0.0;
  }

  // Helper: safely convert anything to int
  static int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] is List) ? List.from(json['images']) : <dynamic>[];
    final firstImage = images.isNotEmpty ? images.first.toString() : '';

    return Product(
      id: _toInt(json['id']),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: _toDouble(json['price']),
      image: firstImage,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'image': image,
      };

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: _toInt(map['id']),
      title: (map['title'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      price: _toDouble(map['price']),
      image: (map['image'] ?? '').toString(),
    );
  }
}
