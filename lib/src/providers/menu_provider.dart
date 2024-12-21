// import 'package:flutter/foundation.dart';
// import '../config/database.dart';
// import '../models/combo.dart';
// import '../models/menu_item.dart';

// class MenuProvider with ChangeNotifier {
//   final DatabaseConfig _db = DatabaseConfig();
//   List<MenuItem> _items = [];
//   List<String> _categories = [];
//     final List<ComboDeal> _comboDeals = [];
//   String? _selectedCategory;

//   // Getter for categories
//   List<String> get categories {
//     loadCategoryNames();
//     return _categories;
//   }

//    List<ComboDeal> get comboDeals => _comboDeals;

//   // Getter for items
//   List<MenuItem> get items {
//     loadMenuItems();
//     return _items;
//   }

//   // Getter for selected category
//   String? get selectedCategory => _selectedCategory;

//   // Method to set selected category
//   void setSelectedCategory(String? category) {
//     _selectedCategory = category;
//     notifyListeners();
//   }

//   // Load menu items from the database
//   Future<void> loadMenuItems() async {
//     try {
//       final conn = await _db.connection;
//       final results = await conn.query(
//           'SELECT m.*, c.name AS category_name FROM menu_items m JOIN categories c ON m.category_id = c.id');

//       _items =
//           results.map((row) => MenuItem.fromJson(row.toColumnMap())).toList();

//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error loading menu items: $e');
//     }
//   }

//   // Load category names from the database
//   Future<void> loadCategoryNames() async {
//     try {
//       final conn = await _db.connection;
//       final results = await conn.query('SELECT * FROM categories');

//       _categories = results.map((row) => row[1] as String).toList();

//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error loading category names: $e');
//     }
//   }

//   // Add a new menu item
//   Future<void> addMenuItem(MenuItem item) async {
//     try {
//       final conn = await _db.connection;
//       await conn.query(
//         'INSERT INTO menu_items (category_id, name, description, price, is_available) '
//         'VALUES (@categoryId, @name, @description, @price, @isAvailable)',
//         substitutionValues: {
//           'categoryId': item.categoryId,
//           'name': item.name,
//           'description': item.description,
//           'price': item.price,
//           'isAvailable': item.isAvailable,
//         },
//       );
//       await loadMenuItems();
//     } catch (e) {
//       debugPrint('Error adding menu item: $e');
//     }
//   }

//   // Update an existing menu item
//   Future<void> updateMenuItem(MenuItem item) async {
//     try {
//       final conn = await _db.connection;
//       await conn.query(
//         'UPDATE menu_items SET category_id = @categoryId, name = @name, '
//         'description = @description, price = @price, is_available = @isAvailable '
//         'WHERE id = @id',
//         substitutionValues: {
//           'id': item.id,
//           'categoryId': item.categoryId,
//           'name': item.name,
//           'description': item.description,
//           'price': item.price,
//           'isAvailable': item.isAvailable,
//         },
//       );
//       await loadMenuItems();
//     } catch (e) {
//       debugPrint('Error updating menu item: $e');
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import '../config/database.dart';
import '../models/combo.dart';
import '../models/menu_item.dart';

class MenuProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<MenuItem> _items = [];
  List<String> _categories = [];
  final List<ComboDeal> _comboDeals = [];
  String? _selectedCategory;

  // Getter for categories
  List<String> get categories {
    loadCategoryNames();
    return _categories;
  }

  // Getter for combo deals
  List<ComboDeal> get comboDeals {
    loadComboDeals();
    return _comboDeals;
  }

  // Getter for items
  List<MenuItem> get items {
    loadMenuItems();
    return _items;
  }

  // Getter for selected category
  String? get selectedCategory => _selectedCategory;

  // Method to set selected category
  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Load menu items from the database
  Future<void> loadMenuItems() async {
    try {
      final conn = await _db.connection;
      final results = await conn.query(
          'SELECT m.*, c.name AS category_name FROM menu_items m JOIN categories c ON m.category_id = c.id');

      _items =
          results.map((row) => MenuItem.fromJson(row.toColumnMap())).toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading menu items: $e');
    }
  }

  // Load category names from the database
  Future<void> loadCategoryNames() async {
    try {
      final conn = await _db.connection;
      final results = await conn.query('SELECT * FROM categories');

      _categories = results.map((row) => row[1] as String).toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading category names: $e');
    }
  }

  // Load combo deals from the database
  Future<void> loadComboDeals() async {
    try {
      final conn = await _db.connection;

      // First, fetch combo deals
      final comboResults = await conn.query('SELECT * FROM combo_deals');
      final comboDeals = comboResults.map((row) {
        return ComboDeal(
          id: row[0],
          name: row[1],
          description: row[2],
          price: row[3],
          isAvailable: row[4],
        );
      }).toList();

      // Now fetch the combo items for each combo deal
      for (var comboDeal in comboDeals) {
        final comboItemsResults = await conn.query(
            'SELECT mi.id, mi.name, ci.quantity '
            'FROM combo_items ci '
            'JOIN menu_items mi ON mi.id = ci.menu_item_id '
            'WHERE ci.combo_id = @comboId',
            substitutionValues: {'comboId': comboDeal.id});

        // Map combo items to the ComboDeal
        comboDeal.items = comboItemsResults.map((row) {
          return ComboItem(
            menuItemId: row[0],
            // name: row[1],
            quantity: row[2],
          );
        }).toList();
      }

      _comboDeals.clear();
      _comboDeals.addAll(comboDeals);

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading combo deals: $e');
    }
  }

  // Add a new menu item
  Future<void> addMenuItem(MenuItem item) async {
    try {
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
      await loadMenuItems();
    } catch (e) {
      debugPrint('Error adding menu item: $e');
    }
  }

  // Update an existing menu item
  Future<void> updateMenuItem(MenuItem item) async {
    try {
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
      await loadMenuItems();
    } catch (e) {
      debugPrint('Error updating menu item: $e');
    }
  }
}
