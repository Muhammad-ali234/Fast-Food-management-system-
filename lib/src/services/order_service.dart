// ignore_for_file: unused_import

import '../config/database.dart';
import '../models/order.dart';
import '../utils/db_utils.dart';

class OrderService {
  final DatabaseConfig _db;

  OrderService({DatabaseConfig? db}) : _db = db ?? DatabaseConfig();

  Future<List<Order>> getOrders({String? status}) async {
    final conn = await _db.connection;
    final whereClause = status != null ? 'WHERE o.status = @status' : '';

    final results = await conn.query(
      'SELECT o.*, oi.menu_item_id, oi.quantity, oi.price '
      'FROM orders o '
      'LEFT JOIN order_items oi ON o.id = oi.order_id '
      '$whereClause '
      'ORDER BY o.created_at DESC',
      substitutionValues: status != null ? {'status': status} : null,
    );

    final Map<int, Order> orderMap = {};
    for (final row in results) {
      final map = row.toColumnMap();
      final orderId = map['id'] as int;

      if (!orderMap.containsKey(orderId)) {
        orderMap[orderId] = Order.fromJson(map);
      }

      if (map['menu_item_id'] != null) {
        orderMap[orderId]!.addItem(
          map['menu_item_id'] as int,
          map['quantity'] as int,
          map['price'] as double,
        );
      }
    }

    return orderMap.values.toList();
  }

  Future<int> createOrder(Order order) async {
    final conn = await _db.connection;
    final orderId = await conn.transaction((ctx) async {
      final orderResult = await ctx.query(
        'INSERT INTO orders (order_type, customer_name, customer_phone, status, total_amount) '
        'VALUES (@type, @name, @phone, @status, @total) RETURNING id',
        substitutionValues: {
          'type': order.orderType,
          'name': order.customerName,
          'phone': order.customerPhone,
          'status': order.status,
          'total': order.totalAmount,
        },
      );

      final orderId = orderResult.first[0] as int;

      for (final item in order.items) {
        await ctx.query(
          'INSERT INTO order_items (order_id, menu_item_id, quantity, price) '
          'VALUES (@orderId, @itemId, @quantity, @price)',
          substitutionValues: {
            'orderId': orderId,
            'itemId': item.menuItemId,
            'quantity': item.quantity,
            'price': item.price,
          },
        );
      }

      return orderId;
    });

    return orderId;
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    final conn = await _db.connection;
    await conn.query(
      'UPDATE orders SET status = @status WHERE id = @id',
      substitutionValues: {
        'id': orderId,
        'status': status,
      },
    );
  }
}
