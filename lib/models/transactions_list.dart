import 'dart:convert';
import 'package:dart_flutter_despesas_pessoais/models/transactions_model.dart';
import 'package:dart_flutter_despesas_pessoais/utils/my_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionsList extends ChangeNotifier {
  final List<TransactionsModel> _transactions = [];

  List<TransactionsModel> get transactions => [..._transactions];

  Future<void> addTransaction(TransactionsModel transaction) async {
    final res = await http.post(
      Uri.parse('${MyConst().urlTransactions}.json'),
      body: jsonEncode({
        'title': transaction.title,
        'date': transaction.date.toIso8601String(),
        'amount': transaction.amount,
      }),
    );

    if (res.statusCode >= 400) throw Exception('Error on request');

    TransactionsModel newTransaction = TransactionsModel(
      id: jsonDecode(res.body)['name'],
      title: transaction.title,
      date: transaction.date,
      amount: transaction.amount,
    );

    _transactions.add(newTransaction);
    notifyListeners();
    return Future.value();
  }

  Future<void> removeTransaction(String id) async {
    final index = _transactions.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final transaction = _transactions[index];
      _transactions.removeAt(index);
      notifyListeners();

      final res =
          await http.delete(Uri.parse('${MyConst().urlTransactions}/$id.json'));

      if (res.statusCode >= 400) {
        _transactions.insert(index, transaction);
        notifyListeners();
        throw Exception('Error on request');
      }
    }
  }

  Future<void> fetchTransactions() async {
    final res = await http.get(Uri.parse('${MyConst().urlTransactions}.json'));
    final Map<String, dynamic> data = jsonDecode(res.body);

    data.forEach((key, value) {
      _transactions.add(TransactionsModel(
        id: key,
        title: value['title'],
        date: DateTime.parse(value['date']),
        amount: value['amount'],
      ));
    });

    notifyListeners();
    return Future.value();
  }

  List<double> get getWeeklyAmounts {
    List<double> weeklyAmounts = List<double>.filled(7, 0.0);

    for (var transaction in _transactions) {
      final dayOfWeek = transaction.date.weekday - 1;
      weeklyAmounts[dayOfWeek] += transaction.amount;
    }

    return weeklyAmounts;
  }
}
