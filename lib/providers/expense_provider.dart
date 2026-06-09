import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseProvider extends ChangeNotifier{
    final List<Expense> _expenses = [];

    List<Expense> get expenses => _expenses;

    double get totalAmount{
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

 
}