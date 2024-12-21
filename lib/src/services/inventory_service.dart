// ignore_for_file: unused_import

import '../config/database.dart';
import '../models/inventory_item.dart';
import '../utils/db_utils.dart';

class InventoryService {
  final DatabaseConfig _db;

  InventoryService({DatabaseConfig? db}) : _db = db ?? DatabaseConfig();

  Future<List<InventoryItem>> getInventoryItems() async {
    final conn = await _db.connection;
    final results =
        await conn.query('SELECT * FROM inventory_items ORDER BY name');
    return results
        .map((row) => InventoryItem.fromJson(row.toColumnMap()))
        .toList();
  }

  Future<void> updateStock(
      int itemId, double quantity, String transactionType) async {
    final conn = await _db.connection;
    await conn.transaction((ctx) async {
      await ctx.query(
        'UPDATE inventory_items SET quantity = quantity + @change WHERE id = @id',
        substitutionValues: {
          'id': itemId,
          'change': transactionType == 'In' ? quantity : -quantity,
        },
      );

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
  }

  Future<List<Map<String, dynamic>>> getTransactionHistory(int itemId) async {
    final conn = await _db.connection;
    final results = await conn.query(
      'SELECT * FROM inventory_transactions WHERE inventory_item_id = @id ORDER BY created_at DESC',
      substitutionValues: {'id': itemId},
    );
    return results.map((row) => row.toColumnMap()).toList();
  }
}
