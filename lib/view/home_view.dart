import 'package:bill_splitter/view/result_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/bill_view_model.dart';
import 'add_expense_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController personController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BillViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Bill Splitter'),),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: personController,
            decoration: InputDecoration(
              labelText: 'Person Name'
            ),
          ),
          ElevatedButton(onPressed: () {
            if(personController.text.isNotEmpty) {
              vm.addPerson(personController.text);
              personController.clear();
            }
          }, child: Text('Add Person')),
          SizedBox(height: 20,),
          Expanded(child: ListView(
            children: vm.people.map((p) => ListTile(title: Text(p.name),)).toList(),
          )),
          ElevatedButton(onPressed: vm.people.length < 2 ? null : () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddExpenseView()));
          }, child: Text('Add Expense')),
          ElevatedButton(onPressed: vm.expenses.isEmpty ? null : () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ResultView()));
          }, child: Text('View Result'))
        ],
      ),
      ),
    );
  }
}
