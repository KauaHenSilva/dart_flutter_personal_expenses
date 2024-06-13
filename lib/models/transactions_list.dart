import 'dart:convert';
import 'package:dart_flutter_despesas_pessoais/models/transactions_model.dart';
import 'package:dart_flutter_despesas_pessoais/utils/my_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionsList extends ChangeNotifier {
  final List<TransactionsModel> _transactions = [];

  List<TransactionsModel> get transactions => [..._transactions];

  Future<void> addTransaction(TransactionsModel transaction) async {
    _transactions.add(transaction);
    notifyListeners();

    final res = await http.post(
      Uri.parse('${MyConst().urlTransactions}.json'),
      body: jsonEncode({
        'title': transaction.title,
        'date': transaction.date.toIso8601String(),
        'amount': transaction.amount,
      }),
    );

    if (res.statusCode >= 400) {
      _transactions.remove(transaction);
      notifyListeners();
      throw Exception('Error on request');
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
