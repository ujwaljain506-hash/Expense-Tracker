import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/screens/chart_screen.dart';

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
    Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        final total = provider.totalExpenses;
        final budget = provider.budget;
        final progress = (total / budget).clamp(0.0, 1.0);

        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Budget',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress >= 1.0 ? Colors.red : Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Spent: ₹$total'),
                    Text('Budget: ₹$budget'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
    const SizedBox(height: 8),
    const SizedBox(
      height: 250,
      child: ChartScreen(),
    ),
    Expanded(
      child: expenses.isEmpty
          ? const Center(
              child: Text('No expenses yet. Add one!'),
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