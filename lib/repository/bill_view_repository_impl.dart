import 'package:bill_splitter/models/expense.dart';
import 'package:bill_splitter/models/person.dart';
import 'package:bill_splitter/repository/bill_repository.dart';

class BillViewRepositoryImpl extends BillRepository{
  List<Person> _people = [];
  List<Expense> _expenses = [];

  @override
  Future<void> saveData(List<Person> people, List<Expense> espenses) async {
    _people = people;
    _expenses = _expenses;
  }

  @override
  Future<List<Person>> loadPeople() async {
    return _people;
  }

  @override
  Future<List<Expense>> loadExpenses() async {
    return _expenses;
  }
}