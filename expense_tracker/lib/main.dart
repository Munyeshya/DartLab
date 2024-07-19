import 'package:flutter/material.dart';
import 'models/expense.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseListPage(),
    );
  }
}

class ExpenseListPage extends StatefulWidget {
  @override
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final List<Expense> _expenses = [];

  void _addExpense(String title, double amount, DateTime date) {
    setState(() {
      _expenses.add(Expense(title: title, amount: amount, date: date));
    });
  }

  void _editExpense(int index, String title, double amount, DateTime date) {
    setState(() {
      _expenses[index] = Expense(title: title, amount: amount, date: date);
    });
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  double get _totalExpenses {
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  void _showExpenseDialog({Expense? expense, int? index}) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    DateTime selectedDate = expense?.date ?? DateTime.now();

    if (expense != null) {
      titleController.text = expense.title;
      amountController.text = expense.amount.toString();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextButton(
              child: Text('Select Date'),
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),
            Text('Selected Date: ${selectedDate.toLocal()}'.split(' ')[0]),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(expense == null ? 'Add' : 'Edit'),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  amountController.text.isNotEmpty) {
                if (expense == null) {
                  _addExpense(
                    titleController.text,
                    double.parse(amountController.text),
                    selectedDate,
                  );
                } else {
                  _editExpense(
                    index!,
                    titleController.text,
                    double.parse(amountController.text),
                    selectedDate,
                  );
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return ListTile(
                  title: Text(expense.title),
                  subtitle: Text(
                      '${expense.amount.toStringAsFixed(2)} - ${expense.date.toLocal()}'
                          .split(' ')[0]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showExpenseDialog(
                          expense: expense,
                          index: index,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteExpense(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Expenses: ${_totalExpenses.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showExpenseDialog(),
      ),
    );
  }
}
