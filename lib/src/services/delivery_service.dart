import '../config/database.dart';
import '../models/delivery.dart';

class DeliveryService {
  final DatabaseConfig _db;

  DeliveryService({DatabaseConfig? db}) : _db = db ?? DatabaseConfig();

  Future<List<Delivery>> getDeliveries({bool activeOnly = false}) async {
    final conn = await _db.connection;
    final whereClause = activeOnly
        ? "WHERE o.order_type = 'Delivery' AND o.status NOT IN ('Completed', 'Cancelled')"
        : "WHERE o.order_type = 'Delivery'";

    final results =
        await conn.query('SELECT o.*, oi.menu_item_id, oi.quantity, oi.price '
            'FROM orders o '
            'LEFT JOIN order_items oi ON o.id = oi.order_id '
            '$whereClause '
            'ORDER BY o.created_at DESC');

    final Map<int, Delivery> deliveryMap = {};
    for (final row in results) {
      final map = row.toColumnMap();
      final orderId = map['id'] as int;

      if (!deliveryMap.containsKey(orderId)) {
        deliveryMap[orderId] = Delivery.fromJson(map);
      }

      if (map['menu_item_id'] != null) {
        deliveryMap[orderId]!.addItem(
          map['menu_item_id'] as int,
          map['quantity'] as int,
          map['price'] as double,
        );
      }
    }

    return deliveryMap.values.toList();
  }

  Future<void> updateDeliveryStatus(int orderId, String status) async {
    final conn = await _db.connection;
    await conn.query(
      'UPDATE orders SET status = @status WHERE id = @id',
      substitutionValues: {
        'id': orderId,
        'status': status,
      },
    );
  }

  Future<Map<String, dynamic>> getDeliveryStats() async {
    final conn = await _db.connection;
    final results = await conn.query("SELECT COUNT(*) as total_deliveries, "
        "COUNT(CASE WHEN status = 'Completed' THEN 1 END) as completed_deliveries, "
        "AVG(CASE WHEN status = 'Completed' THEN "
        "EXTRACT(EPOCH FROM (updated_at - created_at))/60 END) as avg_delivery_time "
        "FROM orders WHERE order_type = 'Delivery'");
    return results.first.toColumnMap();
  }
}
