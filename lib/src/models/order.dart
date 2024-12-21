class OrderItem {
  final int menuItemId;
  int quantity;
  final double price;

  OrderItem({
    required this.menuItemId,
    required this.quantity,
    required this.price,
  });
}

class Order {
  final int id;
  final String orderType;
  final String customerName;
  final String customerPhone;
  final String status;
  final double totalAmount;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.orderType,
    required this.customerName,
    required this.customerPhone,
    required this.status,
    required this.totalAmount,
    List<OrderItem>? items,
  }) : items = items ?? [];

  // factory Order.fromJson(Map<String, dynamic> json) {
  //   return Order(
  //     id: json['id'],
  //     orderType: json['order_type'],
  //     customerName: json['customer_name'],
  //     customerPhone: json['customer_phone'],
  //     status: json['status'],
  //     totalAmount: json['total_amount'],
  //     // totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0.0,
  //   );
  // }
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderType: json['order_type'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      status: json['status'],
      totalAmount: json['total_amount'] is double
          ? json['total_amount']
          : double.tryParse(json['total_amount'].toString()) ?? 0.0,
    );
  }

  void addItem(int menuItemId, int quantity, double price) {
    items.add(OrderItem(
      menuItemId: menuItemId,
      quantity: quantity,
      price: price,
    ));
  }
}
