import 'package:flow_fin/widgets/expenses_list/expenses_list.dart';
import 'package:flow_fin/models/expense.dart';
import 'package:flow_fin/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Nasi Goreng',
      amount: 10,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Bus',
      amount: 20,
      date: DateTime.now(),
      category: Category.transport,
    ),
    Expense(
      title: 'Kebutuhan Bulanan',
      amount: 30,
      date: DateTime.now(),
      category: Category.shopping,
    ),
    Expense(
      title: 'Bali',
      amount: 40,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Financial Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('Ini Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
