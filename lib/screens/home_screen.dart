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
           body: Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget: ₹${provider.totalExpenses.toStringAsFixed(2)} / ₹${provider.budgetLimit.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (provider.totalExpenses / provider.budgetLimit).clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              provider.totalExpenses >= provider.budgetLimit
                  ? Colors.red
                  : Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            provider.remainingBudget >= 0
                ? '₹${provider.remainingBudget.toStringAsFixed(2)} remaining'
                : 'Over budget by ₹${(provider.remainingBudget * -1).toStringAsFixed(2)}',
            style: TextStyle(
              color: provider.remainingBudget >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: expenses.isEmpty
          ? const Center(child: Text('No expenses yet. Add one!'))
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
    ),
  ],
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