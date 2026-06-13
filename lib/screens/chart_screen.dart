import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/models/expense.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  Color _categoryColor(Category category) {
    switch (category) {
      case Category.food:
        return Colors.teal;
      case Category.travel:
        return Colors.orange;
      case Category.bills:
        return Colors.red;
      case Category.shopping:
        return Colors.purple;
      case Category.other:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    final data = provider.expensesByCategory;

    if (data.isEmpty) {
      return const Center(child: Text('No expenses to show.'));
    }

    final sections = data.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key.name,
        color: _categoryColor(entry.key),
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(sections: sections),
      ),
    );
  }
}