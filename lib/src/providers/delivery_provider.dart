import 'package:flutter/foundation.dart';
import '../config/database.dart';
import '../models/delivery.dart';

class DeliveryProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<Delivery> _deliveries = [];
  List<Delivery> _activeDeliveries = [];

  List<Delivery> get deliveries => _deliveries;
  List<Delivery> get activeDeliveries => _activeDeliveries;

  Future<void> loadDeliveries() async {
    try {
      final conn = await _db.connection;
      final results = await conn.query(
        'SELECT o.*, oi.menu_item_id, oi.quantity, oi.price '
        'FROM orders o '
        'LEFT JOIN order_items oi ON o.id = oi.order_id '
        'WHERE o.order_type = \'Delivery\' '
        'ORDER BY o.created_at DESC'
      );
      
      // Group results by delivery
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
      
      _deliveries = deliveryMap.values.toList();
      _updateActiveDeliveries();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading deliveries: $e');
    }
  }

  void _updateActiveDeliveries() {
    _activeDeliveries = _deliveries.where((delivery) => 
      delivery.status != 'Completed' && delivery.status != 'Cancelled'
    ).toList();
  }

  Future<void> updateDeliveryStatus(int orderId, String status) async {
    try {
      final conn = await _db.connection;
      await conn.query(
        'UPDATE orders SET status = @status WHERE id = @id',
        substitutionValues: {
          'id': orderId,
          'status': status,
        },
      );
      await loadDeliveries();
    } catch (e) {
      debugPrint('Error updating delivery status: $e');
    }
  }
}