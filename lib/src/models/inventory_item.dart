// class InventoryItem {
//   final int id;
//   final String name;
//   double quantity;
//   final String unit;
//   final double minQuantity;

//   InventoryItem({
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.unit,
//     required this.minQuantity,
//   });

//   // factory InventoryItem.fromJson(Map<String, dynamic> json) {
//   //   return InventoryItem(
//   //     id: json['id'],
//   //     name: json['name'],
//   //     quantity: json['quantity'],
//   //     unit: json['unit'],
//   //     minQuantity: json['min_quantity'],
//   //   );
//   // }
//   factory InventoryItem.fromJson(Map<String, dynamic> json) {
//     return InventoryItem(
//       id: json['id'],
//       name: json['name'],
//       quantity:
//           double.tryParse(json['quantity'].toString()) ?? 0.0, // Safely parse
//       unit: json['unit'],
//       minQuantity: double.tryParse(json['min_quantity'].toString()) ??
//           0.0, // Safely parse
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'quantity': quantity,
//       'unit': unit,
//       'min_quantity': minQuantity,
//     };
//   }
// }

class InventoryItem {
  final int id;
  final String name;
  double quantity;
  final String unit;
  final double minQuantity;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.minQuantity,
  });

  // Factory constructor to create an InventoryItem from JSON
  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      name: json['name'],
      quantity: double.tryParse(json['quantity'].toString()) ?? 0.0,
      unit: json['unit'],
      minQuantity: double.tryParse(json['min_quantity'].toString()) ?? 0.0,
    );
  }

  // Method to convert InventoryItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'min_quantity': minQuantity,
    };
  }

  // CopyWith method for creating a modified copy of an InventoryItem
  InventoryItem copyWith({
    int? id,
    String? name,
    double? quantity,
    String? unit,
    double? minQuantity,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      minQuantity: minQuantity ?? this.minQuantity,
    );
  }
}
