class OrderItem {
  final int? menuItemId;
  final int? comboId;
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    this.menuItemId,
    this.comboId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'menu_item_id': menuItemId,
    'combo_id': comboId,
    'quantity': quantity,
    'price': price,
  };
}