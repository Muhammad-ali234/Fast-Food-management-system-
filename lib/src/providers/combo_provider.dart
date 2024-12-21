import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';
import '../models/combo.dart';

class ComboProvider with ChangeNotifier {
  final PostgreSQLConnection _connection;
  final List<ComboDeal> _combos = [];

  ComboProvider(this._connection);

  List<ComboDeal> get combos => _combos;

  Future<void> createCombo(ComboDeal combo) async {
    print("ali");
    try {
      final result = await _connection.query(
        'INSERT INTO combo_deals (name, description, price, is_available) '
        'VALUES (@name, @desc, @price, @available) RETURNING id',
        substitutionValues: {
          'name': combo.name,
          'desc': combo.description,
          'price': combo.price,
          'available': combo.isAvailable,
        },
      );

      final comboId = result[0][0] as int;

      for (var item in combo.items) {
        await _connection.query(
          'INSERT INTO combo_items (combo_id, menu_item_id, quantity) '
          'VALUES (@comboId, @itemId, @quantity)',
          substitutionValues: {
            'comboId': comboId,
            'itemId': item.menuItemId,
            'quantity': item.quantity,
          },
        );
      }

      notifyListeners();
    } catch (e) {
      print('Error creating combo: $e');
      rethrow;
    }
  }
}
