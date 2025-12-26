import 'package:flutter/cupertino.dart';

import '../models/Expense.dart';
import '../models/person.dart';
import '../repository/bill_repository.dart';

class BillViewModel extends ChangeNotifier{
  final BillRepository repository;

  List<Person> people = [];
  List<Expense> expenses = [];

  BillViewModel(this.repository);

  void addPerson(String name) {
    people.add(
        Person(
            id: DateTime.now().toString(),
            name: name
        )
    );
    notifyListeners();
  }

  void addExpense(String title, double amount, String paidBy) {
   expenses.add(Expense(
       title: title,
       amount: amount,
       paidBy: paidBy
   ));
   notifyListeners();
  }




  Map<String, dynamic> calculateBalance() {
    final Map<String, dynamic> balance = {};

    if(people.isEmpty) return balance;

    for(var person in people) {
      balance[person.name] == 0.0;
    }

    for(var expense in expenses) {
      final key = expense.paidBy;

      if(!balance.containsKey(key)) {
        balance[key] = 0.0;
      }
      balance[key] = balance[key]! + expense.amount;
    }

    final double splitAmount = expenses.fold(0.0, (sum, e) => sum + e.amount);


    for(final person in people) {
      final key = person.name;

      if(!balance.containsKey(key)){
        balance[key] = 0.0;
      }

      balance[key] = balance[key]! - splitAmount;
    }

    return balance;
  }

  List<String> getSettlements() {
    final balances = calculateBalance();
    final settlements = <String> [];

    final receivers = <String, double>{};
    final payers = <String, double>{};
    const double epsilon = 0.01;

    balances.forEach((name, amount) {
      if(amount > epsilon) {
        receivers[name] = amount;
      } else if(amount < -epsilon) {
        payers[name] = -amount;
      }
    });

    for(final payer in payers.entries) {
      var remainingPay = payer.value;

      for(final receiver in receivers.entries) {
        if(remainingPay == epsilon) break;
        if(receiver.value == epsilon) continue;

        final transfer = remainingPay < receiver.value ? remainingPay : receiver.value;
        
        settlements.add(
          '${payer.key} pays ${receiver.key} ₹${transfer.toStringAsFixed(2)}'
        );

        remainingPay -= transfer;
        receivers[receiver.key] = receiver.value - transfer;
      }
    }
    return settlements;
  }
}