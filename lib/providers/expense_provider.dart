import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [];
  double _budget = 10000;

  List<Expense> get expenses => _expenses;

  double get budget => _budget;

  void setBudget(double amount) {
    _budget = amount;
    notifyListeners();
  }

  double get totalExpenses {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  Map<Category, double> get expensesByCategory {
  final map = <Category, double>{};
  for (final expense in _expenses) {
    map[expense.category] = (map[expense.category] ?? 0) + expense.amount;
  }
  return map;
}

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }
}
