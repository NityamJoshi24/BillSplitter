import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../models/person.dart';
import '../repository/bill_repository.dart';

class BillViewModel extends ChangeNotifier {
  final BillRepository repository;

  List<Person> people = [];
  List<Expense> expenses = [];

  Map<String, double> _balances = {};
  List<String> _settlements = [];

  BillViewModel(this.repository);

  void addPerson(String name) {
    people.add(
      Person(
        id: DateTime.now().toString(),
        name: name,
      ),
    );

    _recalculate();
    notifyListeners();
  }

  void addExpense(String title, double amount, String paidBy) {
    expenses.add(
      Expense(
        title: title,
        amount: amount,
        paidBy: paidBy,
      ),
    );

    _recalculate();
    notifyListeners();
  }

  void _recalculate() {
    _balances = _calculateBalancesInternal();
    _settlements = _calculateSettlementsInternal();
  }

  Map<String, double> _calculateBalancesInternal() {
    final Map<String, double> balance = {};

    if (people.isEmpty) return balance;

    for (final person in people) {
      balance[person.name] = 0.0; // 🟢 CONFIRMED FIX
    }

    for (final expense in expenses) {
      balance[expense.paidBy] =
          (balance[expense.paidBy] ?? 0) + expense.amount;
    }

    final total =
    expenses.fold(0.0, (sum, e) => sum + e.amount);
    final split = total / people.length;

    for (final person in people) {
      balance[person.name] =
          (balance[person.name] ?? 0) - split;
    }

    return balance;
  }

  List<String> _calculateSettlementsInternal() {
    final settlements = <String>[];
    final receivers = <String, double>{};
    final payers = <String, double>{};

    const double epsilon = 0.01;

    _balances.forEach((name, amount) {
      if (amount > epsilon) {
        receivers[name] = amount;
      } else if (amount < -epsilon) {
        payers[name] = -amount;
      }
    });

    for (final payer in payers.entries) {
      var remaining = payer.value;

      for (final receiver in receivers.entries) {
        if (remaining <= epsilon) break;
        if (receiver.value <= epsilon) continue;

        final transfer =
        remaining < receiver.value ? remaining : receiver.value;

        settlements.add(
          '${payer.key} pays ${receiver.key} ₹${transfer.toStringAsFixed(2)}',
        );

        remaining -= transfer;
        receivers[receiver.key] =
            receiver.value - transfer;
      }
    }

    return settlements;
  }


  Map<String, double> get balances => _balances;

  List<String> get settlements => _settlements;
}
