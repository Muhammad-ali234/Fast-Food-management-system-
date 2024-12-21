class ComboItem {
  final int menuItemId;
  final int quantity;

  ComboItem({
    required this.menuItemId,
    required this.quantity,
  });
}

class ComboDeal {
  final int? id;
  final String name;
  final String description;
  final double price;
  final bool isAvailable;
  final List<ComboItem> items;

  ComboDeal({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isAvailable = true,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'is_available': isAvailable,
  };
}