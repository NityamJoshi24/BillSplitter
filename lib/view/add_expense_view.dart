import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/bill_view_model.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  String? paidBy;


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BillViewModel>(context, listen: false);

    paidBy ??= vm.people.first.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: paidBy,
              items: vm.people
                  .map(
                    (p) => DropdownMenuItem(
                  value: p.name,
                  child: Text(p.name),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  paidBy = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    amountController.text.isEmpty ||
                    paidBy == null) {
                  return;
                }

                vm.addExpense(
                  titleController.text.trim(),
                  double.parse(amountController.text),
                  paidBy!,
                );

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
