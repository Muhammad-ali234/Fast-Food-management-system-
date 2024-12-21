class MenuItem {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final bool isAvailable;

  MenuItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ??
              0.0, // Handle String and null cases
      isAvailable: json['is_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'is_available': isAvailable,
    };
  }
}
