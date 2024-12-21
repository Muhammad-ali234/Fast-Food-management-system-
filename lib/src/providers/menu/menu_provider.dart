// // import 'package:flutter/foundation.dart';
// // import '../../models/menu_item.dart';
// // import 'menu_state.dart';
// // import 'menu_repository.dart';
// // import '../../utils/error_handler.dart';

// // class MenuProvider with ChangeNotifier {
// //   final MenuRepository _repository;
// //   MenuState _state = const MenuState();

// //   MenuProvider({MenuRepository? repository})
// //       : _repository = repository ?? MenuRepository();

// //   MenuState get state => _state;

// //   Future<void> loadMenuItems() async {
// //     _state = _state.copyWith(isLoading: true, error: null);
// //     notifyListeners();

// //     try {
// //       final items = await _repository.getMenuItems();
// //       _state = _state.copyWith(items: items, isLoading: false);
// //       notifyListeners();
// //     } catch (e) {
// //       final error = ErrorHandler.getMessage(e);
// //       _state = _state.copyWith(error: error, isLoading: false);
// //       notifyListeners();
// //       debugPrint('Error loading menu items: $e');
// //     }
// //   }

// Future<void> loadCategories() async {
//   try {
//     final categories = await _repository.getCategories();
//     _state = _state.copyWith(categories: categories);
//     notifyListeners();
//   } catch (e) {
//     debugPrint('Error loading categories: $e');
//   }
// }

// //   Future<void> addMenuItem(MenuItem item) async {
// //     try {
// //       await _repository.addMenuItem(item);
// //       await loadMenuItems();
// //     } catch (e) {
// //       debugPrint('Error adding menu item: $e');
// //     }
// //   }

// //   Future<void> updateMenuItem(MenuItem item) async {
// //     try {
// //       await _repository.updateMenuItem(item);
// //       await loadMenuItems();
// //     } catch (e) {
// //       debugPrint('Error updating menu item: $e');
// //     }
// //   }
// // }

import 'package:ffms/src/config/database.dart';
import 'package:ffms/src/providers/menu/menu_repository.dart';
import 'package:ffms/src/providers/menu/menu_state.dart';
import 'package:flutter/foundation.dart';

import '../../models/menu_item.dart';

// class MenuProvider with ChangeNotifier {
//   final DatabaseConfig _db = DatabaseConfig();
//   List<MenuItem> _items = [];
//   List<String> _categories = [];
//   String? _selectedCategory;

//   // Getter for categories
//   List<String> get categories {
//     loadCategoryNames();
//     return _categories;
//   }

//   // Getter for items
//   List<MenuItem> get items {
//     loadMenuItems();
//     return _items;
//   }

//   // Getter for selected category
//   String? get selectedCategory => _selectedCategory;

//   // Setter for selected category
//   void setSelectedCategory(String? category) {
//     _selectedCategory = category;
//     notifyListeners();
//   }

//   // Method to load menu items
//   Future<void> loadMenuItems() async {
//     try {
//       final conn = await _db.connection;
//       final results = await conn.query(
//           'SELECT m.*, c.name AS category_name FROM menu_items m JOIN categories c ON m.category_id = c.id');

//       _items = results.map((row) => MenuItem.fromJson(row.toColumnMap())).toList();
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error loading menu items: $e');
//     }
//   }

//   // Method to load category names
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

//   // Method to add a new menu item
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

//   // Method to update an existing menu item
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

// class MenuProvider with ChangeNotifier {
//   final DatabaseConfig _db = DatabaseConfig();
//   List<MenuItem> _items = [];
//   List<String> _categories = [];
//   String? _selectedCategory;

//   MenuState _state = const MenuState();
//   final MenuRepository _repository;

//   MenuProvider({MenuRepository? repository})
//       : _repository = repository ?? MenuRepository();

//   // Getter for the current state
//   MenuState get state => _state;

//   // Getter for categories
//   List<String> get categories {
//     loadCategoryNames();
//     return _categories;
//   }

//   // Getter for selected category
//   String? get selectedCategory => _selectedCategory;

//   // Setter for selected category
//   void setSelectedCategory(String? category) {
//     _selectedCategory = category;
//     notifyListeners();
//   }

//   // Method to load menu items
// Future<void> loadMenuItems() async {
//   _state = _state.copyWith(isLoading: true); // Set loading state
//   notifyListeners();

//   try {
//     final conn = await _db.connection;
//     final results = await conn.query(
//         'SELECT m.*, c.name AS category_name FROM menu_items m JOIN categories c ON m.category_id = c.id');

//     _items =
//         results.map((row) => MenuItem.fromJson(row.toColumnMap())).toList();
//     _state = _state.copyWith(isLoading: false, items: _items);
//   } catch (e) {
//     _state = _state.copyWith(isLoading: false, error: e.toString());
//   }
//   notifyListeners();
// }

//   // Method to load category names
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

class MenuProvider with ChangeNotifier {
  final DatabaseConfig _db = DatabaseConfig();
  List<MenuItem> _items = [];
  List<String> _categories = [];
  String? _selectedCategory;

  MenuState _state = const MenuState();
  MenuState get state => _state;

  final MenuRepository _repository;

  MenuProvider({MenuRepository? repository})
      : _repository = repository ?? MenuRepository() {
    loadCategoryNames(); // Load categories when the provider is initialized
  }

  // Getter for categories
  List<String> get categories => _categories;

  // Getter for selected category
  String? get selectedCategory => _selectedCategory;

  // Setter for selected category
  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Method to load category names
  Future<void> loadCategoryNames() async {
    try {
      final conn = await _db.connection;
      final results = await conn.query('SELECT * FROM categories');

      _categories = results.map((row) => row[1] as String).toList();
      notifyListeners(); // Notify listeners once categories are loaded
    } catch (e) {
      debugPrint('Error loading category names: $e');
    }
  }

  Future<void> loadCategories() async {
    try {
      final categories = await _repository.getCategories();
      _state = _state.copyWith(categories: categories);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading categories: $e');
    }
  }

  Future<void> loadMenuItems() async {
    _state = _state.copyWith(isLoading: true); // Set loading state
    notifyListeners();

    try {
      final conn = await _db.connection;
      final results = await conn.query(
          'SELECT m.*, c.name AS category_name FROM menu_items m JOIN categories c ON m.category_id = c.id');

      _items =
          results.map((row) => MenuItem.fromJson(row.toColumnMap())).toList();
      _state = _state.copyWith(isLoading: false, items: _items);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
    notifyListeners();
  }

  // Method to add a new menu item
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

  // Method to update an existing menu item
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
