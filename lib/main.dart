// import 'package:ffms/src/providers/combo_provider.dart';
// import 'package:ffms/src/providers/delivery_provider.dart';
// import 'package:ffms/src/providers/employee_provider.dart';
// import 'package:ffms/src/providers/expense_provider.dart';
// import 'package:ffms/src/providers/inventory_provider.dart';
// import 'package:ffms/src/providers/menu/menu_provider.dart';
// import 'package:ffms/src/providers/order_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:postgres/postgres.dart';
// import 'package:provider/provider.dart';
// import 'package:window_size/window_size.dart';
// import 'dart:io';

// import 'src/app.dart';
// import 'src/providers/auth_provider.dart';
// //import 'src/providers/theme_provider.dart';

// // Your check database function here
// Future<bool> checkDatabaseConnection() async {
//   try {
//     final connection = PostgreSQLConnection(
//       'localhost',
//       5432,
//       'ffms_db',
//       username: 'postgres',
//       password: '07877',
//     );

//     // Try to open a connection
//     await connection.open();
//     print('Database connection successful!');

//     await connection.close();
//     return true;
//   } catch (e) {
//     print('Error connecting to the database: $e');
//     return false;
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Check database connection
//   bool isConnected = await checkDatabaseConnection();
//   if (!isConnected) {
//     print('Failed to connect to the database. Please check your connection.');
//     return; // Stop running the app if the database connection fails
//   }

//   if (Platform.isWindows) {
//     setWindowTitle('Fast Food Management System');
//     setWindowMinSize(const Size(1024, 768));
//   }

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => MenuProvider()),
//         ChangeNotifierProvider(create: (_) => DeliveryProvider()),
//         ChangeNotifierProvider(create: (_) => EmployeeProvider()),
//         ChangeNotifierProvider(create: (_) => ExpenseProvider()),
//         ChangeNotifierProvider(create: (_) => InventoryProvider()),
//         ChangeNotifierProvider(create: (_) => OrderProvider()),
//         ChangeNotifierProvider(
//           create: (_) => ComboProvider(connection),),
//         //  ChangeNotifierProvider(create: (_) => ThemeProvider()),
//       ],
//       child: const FFMSApp(),
//     ),
//   );
// }

import 'package:ffms/src/providers/combo_provider.dart';
import 'package:ffms/src/providers/delivery_provider.dart';
import 'package:ffms/src/providers/employee_provider.dart';
import 'package:ffms/src/providers/expense_provider.dart';
import 'package:ffms/src/providers/inventory_provider.dart';
import 'package:ffms/src/providers/menu/menu_provider.dart';
import 'package:ffms/src/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

import 'src/app.dart';
import 'src/providers/auth_provider.dart';
//import 'src/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database connection
  final connection = PostgreSQLConnection(
    'localhost',
    5432,
    'ffms_db',
    username: 'postgres',
    password: '07877',
  );

  try {
    await connection.open();
    print('Database connection successful!');
  } catch (e) {
    print('Error connecting to the database: $e');
    return; // Exit if the connection fails
  }

  if (Platform.isWindows) {
    setWindowTitle('Fast Food Management System');
    setWindowMinSize(const Size(1024, 768));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ComboProvider(connection)),
        // ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const FFMSApp(),
    ),
  );
}
