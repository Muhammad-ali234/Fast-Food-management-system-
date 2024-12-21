import '../models/expense.dart';
import '../config/database.dart';

class ExpenseService {
  final DatabaseConfig _db = DatabaseConfig();

  Future<List<Expense>> getExpenses() async {
    final conn = await _db.connection;
    final results =
        await conn.query('SELECT * FROM expenses ORDER BY date DESC');
    return results.map((row) => Expense.fromJson(row.toColumnMap())).toList();
  }

  Future<Expense> addExpense(
      String category, double amount, String description) async {
    final conn = await _db.connection;
    final results = await conn.query(
      'INSERT INTO expenses (category, amount, description, date) VALUES (@category, @amount, @description, CURRENT_DATE) RETURNING *',
      substitutionValues: {
        'category': category,
        'amount': amount,
        'description': description,
      },
    );
    return Expense.fromJson(results.first.toColumnMap());
  }

  // Future<Map<String, double>> getExpensesByCategory() async {
  //   final conn = await _db.connection;
  //   final results = await conn.query(
  //     'SELECT category, SUM(amount) as total FROM expenses GROUP BY category',
  //   );

  //   return Map.fromEntries(
  //     results.map((row) => MapEntry(
  //       row['category'] as String,
  //       (row['total'] as num).toDouble(),
  //     )),
  //   );
  // }
}
