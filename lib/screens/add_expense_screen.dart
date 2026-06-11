import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
    const AddExpenseScreen({super.key});

    @override
    State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    Category _selectedCategory = Category.food;

    void _saveExpense() {
        final title = _titleController.text.trim();
        final amount = double.tryParse(_amountController.text.trim());

        if (title.isEmpty || amount == null) {
            return;
        }

        final expense = Expense(
            title: title,
            amount: amount,
            category: _selectedCategory,
            date: DateTime.now(),
        );

        Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
        Navigator.of(context).pop();
    }

    @override
    void dispose() {
        _titleController.dispose();
        _amountController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                    ),
                    DropdownButton<Category>(
                        value: _selectedCategory,
                        items: Category.values.map((cat) {
                            return DropdownMenuItem(
                                value: cat,
                                child: Text(cat.name),
                            );
                        }).toList(),
                        onChanged: (value) {
                            setState(() {
                                _selectedCategory = value!;
                            });
                        },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: _saveExpense,
                        child: const Text('Add Expense'),
                    ),
                ],
            ),          
        );
    }
}