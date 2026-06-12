import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseProvider extends ChangeNotifier{
    final List<Expense> _expenses = [];
    double _budgetLimit = 5000;

    List<Expense> get expenses => _expenses;

    double get totalExpenses {
        return _expenses.fold(0, (sum, expense) => sum + expense.amount);
    }

    void addExpense(Expense expense){
        _expenses.add(expense);
        notifyListeners();
    }

    void deleteExpense(String id){
     _expenses.removeWhere((expense) => expense.id == id);
     notifyListeners();
     }

    double get budgetLimit => _budgetLimit;

    double get remainingBudget => _budgetLimit - totalExpenses;

    void setBudgetLimit(double amount){
        _budgetLimit = amount;
        notifyListeners();
    }

 
}