import 'package:flutter/foundation.dart';
import '../config/database.dart';
import '../models/inventory_item.dart';

// class InventoryProvider with ChangeNotifier {
//   final DatabaseConfig _db = DatabaseConfig();
//   List<InventoryItem> _items = [];
//   List<InventoryItem> _lowStockItems = [];
//   List<InventoryItem> _allItems = []; // Keeps track of unfiltered items

//   List<InventoryItem> get items {
//     loadInventory();
//     return _items;
//   }

//   List<InventoryItem> get lowStockItems => _lowStockItems;

//   /// Load inventory items from the database
//   Future<void> loadInventory() async {
//     try {
//       final conn = await _db.connection;
//       final results =
//           await conn.query('SELECT * FROM inventory_items ORDER BY name');

//       _allItems = results
//           .map((row) => InventoryItem.fromJson(row.toColumnMap()))
//           .toList();
//       _items = List.from(_allItems);
//       _updateLowStockItems();
//       notifyListeners(); // Notify listeners to rebuild the UI
//     } catch (e) {
//       debugPrint('Error loading inventory: $e');
//     }
//   }

class InventoryProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<InventoryItem> _items = [];
  List<InventoryItem> _lowStockItems = [];
  List<InventoryItem> _allItems = []; // Keeps track of unfiltered items

  List<InventoryItem> get items => _items;
  List<InventoryItem> get lowStockItems => _lowStockItems;

  /// Load inventory items from the database
  Future<void> loadInventory() async {
    try {
      final conn = await _db.connection;
      final results =
          await conn.query('SELECT * FROM inventory_items ORDER BY name');

      _allItems = results
          .map((row) => InventoryItem.fromJson(row.toColumnMap()))
          .toList();
      _items = List.from(_allItems);
      _updateLowStockItems();
      notifyListeners(); // Notify listeners to rebuild the UI
    } catch (e) {
      debugPrint('Error loading inventory: $e');
    }
  }

  void updateItem(InventoryItem updatedItem) async {
    final index = _items.indexWhere((item) => item.id == updatedItem.id);

    if (index != -1) {
      try {
        final conn = await _db.connection;
        await conn.query(
          'UPDATE inventory_items SET name = @name, quantity = @quantity, unit = @unit, min_quantity = @minQuantity WHERE id = @id',
          substitutionValues: {
            'id': updatedItem.id,
            'name': updatedItem.name,
            'quantity': updatedItem.quantity,
            'unit': updatedItem.unit,
            'minQuantity': updatedItem.minQuantity,
          },
        );

        _items[index] = updatedItem;

        notifyListeners();
      } catch (e) {
        debugPrint('Error updating item in database: $e');
      }
    } else {
      debugPrint('Item not found in the list.');
    }
  }

  /// Update the list of low stock items
  void _updateLowStockItems() {
    _lowStockItems =
        _allItems.where((item) => item.quantity <= item.minQuantity).toList();
  }

  /// Search inventory items based on a query string
  void searchItems(String query) {
    if (query.isEmpty) {
      _items = List.from(_allItems);
    } else {
      _items = _allItems
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Filter inventory items (all, low stock, or out of stock)
  void filterItems(String filter) {
    if (filter == 'low') {
      _items =
          _allItems.where((item) => item.quantity <= item.minQuantity).toList();
    } else if (filter == 'out') {
      _items = _allItems.where((item) => item.quantity == 0).toList();
    } else {
      _items = List.from(_allItems); // Show all items
    }
    notifyListeners();
  }

  /// Update the stock of an item
  Future<void> updateStock(
      int itemId, double quantity, String transactionType) async {
    try {
      final conn = await _db.connection;
      await conn.transaction((ctx) async {
        // Update inventory quantity
        final result = await ctx.query(
          'UPDATE inventory_items SET quantity = quantity + @change WHERE id = @id',
          substitutionValues: {
            'id': itemId,
            'change': transactionType == 'In' ? quantity : -quantity,
          },
        );

        if (result.affectedRowCount == 0) {
          throw Exception('Item not found in inventory.');
        }

        // Record transaction
        await ctx.query(
          'INSERT INTO inventory_transactions (inventory_item_id, transaction_type, quantity) '
          'VALUES (@itemId, @type, @quantity)',
          substitutionValues: {
            'itemId': itemId,
            'type': transactionType,
            'quantity': quantity,
          },
        );
      });

      // Reload inventory to reflect changes
      await loadInventory();
    } catch (e) {
      debugPrint('Error updating stock: $e');
    }
  }

  /// Add a new inventory item
  Future<int> addItem(InventoryItem item) async {
    try {
      final conn = await _db.connection;
      final result = await conn.query(
        'INSERT INTO inventory_items (name, quantity, unit, min_quantity) '
        'VALUES (@name, @quantity, @unit, @minQuantity) RETURNING id',
        substitutionValues: {
          'name': item.name,
          'quantity': item.quantity,
          'unit': item.unit,
          'minQuantity': item.minQuantity,
        },
      );

      final newId = result.first[0] as int;
      await loadInventory(); // Refresh inventory after adding
      return newId;
    } catch (e) {
      debugPrint('Error adding item: $e');
      throw Exception('Failed to add inventory item');
    }
  }
}
