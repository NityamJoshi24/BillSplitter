import 'package:bill_splitter/models/Expense.dart';
import 'package:bill_splitter/models/person.dart';

abstract class BillRepository {
  Future<void> saveData(List<Person> people, List<Expense> expenses);
  Future<List<Person>> loadPeople();
  Future<List<Expense>> loadExpenses();
}