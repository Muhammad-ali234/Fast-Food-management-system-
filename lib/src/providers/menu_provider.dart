import 'package:flutter/foundation.dart';
import '../config/database.dart';
import '../models/menu_item.dart';

// class MenuProvider with ChangeNotifier {
//   final DatabaseConfig _db = DatabaseConfig();
//   List<MenuItem> _items = [];
//   List<String> _categories = [];

//   // List<MenuItem> get items => _items;
//   // List<String> get categories => _categories;

//   List<String> get categories {
//     loadCategoryNames();

//     return _categories;
//   }

//   List<MenuItem> get items {
//     loadMenuItems();
//     return _items;
//   }

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

//   // Future<void> loadCategories() async {
//   //   try {
//   //     final conn = await _db.connection;
//   //     final results =
//   //         await conn.query('SELECT name FROM categories ORDER BY name');
//   //     _categories = results.map((row) => row[0] as String).toList();
//   //     notifyListeners();
//   //   } catch (e) {
//   //     debugPrint('Error loading categories: $e');
//   //   }
//   // }

//   // Future<void> loadCategories() async {
//   //   try {
//   //     final conn = await _db.connection;
//   //     final results =
//   //         await conn.query('SELECT name FROM categories ORDER BY name');
//   //     debugPrint('Raw Categories Results: ${results.length}');
//   //     _categories = results.map((row) => row[0] as String).toList();
//   //     debugPrint('Parsed Categories: $_categories');
//   //     notifyListeners();
//   //   } catch (e) {
//   //     debugPrint('Error loading categories: $e');
//   //   }
//   // }
//   Future<void> loadCategoryNames() async {
//     try {
//       final conn = await _db.connection;

//       // Fetch all categories
//       final results = await conn.query('SELECT * FROM categories');

//       // Extract only the names (assuming "name" is at index 1 in the result row)
//       _categories = results.map((row) => row[1] as String).toList();

//       // Log the extracted names
//       debugPrint('Extracted names: $_categories');

//       notifyListeners(); // Notify listeners about the updated names
//     } catch (e) {
//       debugPrint('Error loading category names: $e');
//     }
//   }

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

class MenuProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<MenuItem> _items = [];
  List<String> _categories = [];
  String? _selectedCategory;

  // Getter for categories
  List<String> get categories {
    loadCategoryNames();
    return _categories;
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
