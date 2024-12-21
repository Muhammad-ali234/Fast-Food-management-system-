import 'package:flutter/foundation.dart';
import '../config/database.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<Order> _orders = [];
  List<Order> _pendingOrders = [];

  List<Order> get orders => _orders;
  List<Order> get pendingOrders =>
      _pendingOrders.where((order) => order.status == 'Pending').toList();

  // Future<void> loadOrders() async {
  //   try {
  //     final conn = await _db.connection;
  //     final results = await conn.query(
  //       'SELECT o.*, oi.menu_item_id, oi.quantity, oi.price '
  //       'FROM orders o '
  //       'LEFT JOIN order_items oi ON o.id = oi.order_id '
  //       'ORDER BY o.created_at DESC'
  //     );

  //     // Group results by order
  //     final Map<int, Order> orderMap = {};
  //     for (final row in results) {
  //       final map = row.toColumnMap();
  //       final orderId = map['id'] as int;

  //       if (!orderMap.containsKey(orderId)) {
  //         orderMap[orderId] = Order.fromJson(map);
  //       }

  //       if (map['menu_item_id'] != null) {
  //         orderMap[orderId]!.addItem(
  //           map['menu_item_id'] as int,
  //           map['quantity'] as int,
  //           map['price'] as double,
  //         );
  //       }
  //     }

  //     _orders = orderMap.values.toList();
  //     _updatePendingOrders();
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint('Error loading orders: $e');
  //   }
  // }
  Future<void> loadOrders() async {
    try {
      final conn = await _db.connection;
      final results = await conn.query(
          'SELECT o.id, o.order_type, o.customer_name, o.customer_phone, o.status, '
          '       o.total_amount::DOUBLE PRECISION AS total_amount, o.created_at, '
          '       oi.menu_item_id, oi.quantity, oi.price::DOUBLE PRECISION AS price '
          'FROM orders o '
          'LEFT JOIN order_items oi ON o.id = oi.order_id '
          'ORDER BY o.created_at DESC');

      // Group results by order
      final Map<int, Order> orderMap = {};
      for (final row in results) {
        final map = row.toColumnMap();
        final orderId = map['id'] as int;

        // Initialize order if not already present
        orderMap.putIfAbsent(orderId, () => Order.fromJson(map));

        // Add item if exists
        if (map['menu_item_id'] != null) {
          orderMap[orderId]!.addItem(
            map['menu_item_id'] as int,
            map['quantity'] as int,
            (map['price'] as num).toDouble(),
          );
        }
      }

      _orders = orderMap.values.toList();
      _updatePendingOrders();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  void _updatePendingOrders() {
    _pendingOrders =
        _orders.where((order) => order.status == 'Pending').toList();
  }

  Future<void> createOrder(Order order) async {
    try {
      final conn = await _db.connection;
      await conn.transaction((ctx) async {
        // Create order
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

        // Add order items
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
      });

      await loadOrders();
    } catch (e) {
      debugPrint('Error creating order: $e');
    }
  }

  // Future<void> updateOrderStatus(int orderId, String status) async {
  //   try {
  //     final conn = await _db.connection;
  //     await conn.query(
  //       'UPDATE orders SET status = @status WHERE id = @id',
  //       substitutionValues: {
  //         'id': orderId,
  //         'status': status,
  //       },
  //     );
  //     await loadOrders();
  //   } catch (e) {
  //     debugPrint('Error updating order status: $e');
  //   }
  // }
  // void updateOrderStatus(int orderId, String newStatus) {
  //   final index = _orders.indexWhere((order) => order.id == orderId);
  //   if (index != -1) {
  //     _orders[index] = Order(
  //       id: _orders[index].id,
  //       orderType: _orders[index].orderType,
  //       customerName: _orders[index].customerName,
  //       customerPhone: _orders[index].customerPhone,
  //       status: newStatus,
  //       totalAmount: _orders[index].totalAmount,
  //       items: _orders[index].items,
  //     );
  //     notifyListeners(); // Notify listeners to rebuild UI
  //   }
  // }

  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    try {
      final conn = await _db.connection;

      // Update the order status in the database
      await conn.query(
        'UPDATE orders SET status = @status WHERE id = @id',
        substitutionValues: {
          'id': orderId,
          'status': newStatus,
        },
      );

      // Now update the local list and notify listeners
      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = Order(
          id: _orders[index].id,
          orderType: _orders[index].orderType,
          customerName: _orders[index].customerName,
          customerPhone: _orders[index].customerPhone,
          status: newStatus,
          totalAmount: _orders[index].totalAmount,
          items: _orders[index].items,
        );
        notifyListeners();
      }

      // Optionally reload orders from the database
      await loadOrders();
    } catch (e) {
      debugPrint('Error updating order status: $e');
    }
  }
}
