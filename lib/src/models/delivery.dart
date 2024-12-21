import 'order.dart';

class Delivery extends Order {
  Delivery({
    required super.id,
    required super.orderType,
    required super.customerName,
    required super.customerPhone,
    required super.status,
    required super.totalAmount,
    super.items,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      orderType: json['order_type'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      status: json['status'],
      totalAmount: json['total_amount'],
    );
  }
}