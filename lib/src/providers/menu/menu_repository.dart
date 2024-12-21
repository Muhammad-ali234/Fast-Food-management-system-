import '../../config/database.dart';
import '../../models/menu_item.dart';

class MenuRepository {
  final DatabaseConfig _db;

  MenuRepository({DatabaseConfig? db}) : _db = db ?? DatabaseConfig();

  Future<List<MenuItem>> getMenuItems() async {
    final conn = await _db.connection;
    final results = await conn
        .query('SELECT m.*, c.name as category_name FROM menu_items m '
            'LEFT JOIN categories c ON m.category_id = c.id '
            'ORDER BY m.name');

    return results.map((row) => MenuItem.fromJson(row.toColumnMap())).toList();
  }

  Future<List<String>> getCategories() async {
    final conn = await _db.connection;
    final results =
        await conn.query('SELECT name FROM categories ORDER BY name');
    return results.map((row) => row[0] as String).toList();
  }

  Future<void> addMenuItem(MenuItem item) async {
    final conn = await _db.connection;
    await conn.query(
      'INSERT INTO menu_items (category_id, name, description, price, is_available) '
      'VALUES (@categoryId, @name, @description, @price, @isAvailable)',
      substitutionValues: {
        'categoryId': item.categoryId,
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'isAvailable': item.isAvailable,
      },
    );
  }

  Future<void> updateMenuItem(MenuItem item) async {
    final conn = await _db.connection;
    await conn.query(
      'UPDATE menu_items SET category_id = @categoryId, name = @name, '
      'description = @description, price = @price, is_available = @isAvailable '
      'WHERE id = @id',
      substitutionValues: {
        'id': item.id,
        'categoryId': item.categoryId,
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'isAvailable': item.isAvailable,
      },
    );
  }
}
