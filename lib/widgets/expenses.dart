import 'package:flow_fin/widgets/chart/chart.dart';
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
      amount: 10000,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Bus',
      amount: 5000,
      date: DateTime.now(),
      category: Category.transport,
    ),
    Expense(
      title: 'Kebutuhan Bulanan',
      amount: 20000,
      date: DateTime.now(),
      category: Category.shopping,
    ),
    Expense(
      title: 'Bali',
      amount: 30000,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

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
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
