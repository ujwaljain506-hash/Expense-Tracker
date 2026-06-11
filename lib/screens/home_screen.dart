import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
        final provider = Provider.of<ExpenseProvider>(context);
        final expenses = provider.expenses;

        return Scaffold(
            appBar: AppBar(
                title: const Text('Expense Tracker'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: expenses.isEmpty
                ? const Center(
                    child: Text('No expenses added yet!'),
                )
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                        final expense = expenses[index];
                        return ListTile(
                            title: Text(expense.title),
                            subtitle: Text(expense.category.name),
                            trailing: Text('₹${expense.amount}'),
                            );
                    },
                 ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const AddExpenseScreen(),
                        );
                    },
                    child: const Icon(Icons.add),
                ),
        );
    }
}