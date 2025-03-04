import 'package:flow_fin/models/expense.dart';
import 'package:flow_fin/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (BuildContext context, int index) => ExpenseItem(expenses[index]),
    );
  }
}
