import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/bill_view_model.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BillViewModel>(context);
    final settlement = vm.settlements;

    return Scaffold(
      appBar: AppBar(title: Text('Settlements'),),
      body: settlement.isEmpty
          ? Center(child: Text('No Payments Needed'),)
          : ListView.builder(
          itemCount: settlement.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.swap_horiz),
              title: Text(settlement[index]),
            );
          }
      )
    );
  }
}
