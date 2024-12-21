// class ComboItem {
//   final int menuItemId;
//   final int quantity;

//   ComboItem({
//     required this.menuItemId,
//     required this.quantity,
//   });
// }

// class ComboDeal {
//   final int? id;
//   final String name;
//   final String description;
//   final double price;
//   final bool isAvailable;
//   List<ComboItem> items;

//   ComboDeal({
//     this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     this.isAvailable = true,
//     this.items = const [],
//   });

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'description': description,
//         'price': price,
//         'is_available': isAvailable,
//       };
// }

class ComboItem {
  final int menuItemId;
  final int quantity;

  ComboItem({
    required this.menuItemId,
    required this.quantity,
  });

  // Factory method to create ComboItem from JSON
  factory ComboItem.fromJson(Map<String, dynamic> json) {
    return ComboItem(
      menuItemId: json['menu_item_id'],
      quantity: json['quantity'],
    );
  }

  // Convert ComboItem to JSON
  Map<String, dynamic> toJson() => {
        'menu_item_id': menuItemId,
        'quantity': quantity,
      };
}

class ComboDeal {
  final int? id;
  final String name;
  final String description;
  final double price;
  final bool isAvailable;
  List<ComboItem> items;

  ComboDeal({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isAvailable = true,
    this.items = const [],
  });

  // Factory method to create ComboDeal from JSON
  factory ComboDeal.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List?; // Check for the 'items' list
    List<ComboItem> itemList = list != null
        ? list.map((item) => ComboItem.fromJson(item)).toList()
        : [];

    // Handling price conversion
    double parsedPrice = 0.0;
    var priceValue = json['price'];

    if (priceValue is String) {
      parsedPrice = double.tryParse(priceValue) ??
          0.0; // If it's a String, try to parse it as double
    } else if (priceValue is double) {
      parsedPrice = priceValue; // If it's already a double, use it as is
    } else if (priceValue is int) {
      parsedPrice =
          priceValue.toDouble(); // If it's an integer, convert it to double
    }

    return ComboDeal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: parsedPrice,
      isAvailable: json['is_available'] ?? true, // Default to true if null
      items: itemList,
    );
  }

  // Convert ComboDeal to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'is_available': isAvailable,
        'items': items.map((item) => item.toJson()).toList(),
      };
}
