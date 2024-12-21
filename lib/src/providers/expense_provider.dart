import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseProvider with ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();

  List<Expense> _expenses = [];
  final Map<String, double> _expensesByCategory = {};

  List<Expense> get expenses => _expenses;
  Map<String, double> get expensesByCategory => _expensesByCategory;

  Future<void> fetchExpenses() async {
    _expenses = await _expenseService.getExpenses();
    notifyListeners();
  }

  // Future<void> fetchExpensesByCategory() async {
  //   _expensesByCategory = await _expenseService.getExpensesByCategory();
  //   notifyListeners();
  // }

  Future<void> addExpense(
      String category, double amount, String description) async {
    await _expenseService.addExpense(category, amount, description);
    await fetchExpenses(); // Refresh the expense list
  }
}
