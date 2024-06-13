import 'package:dart_flutter_despesas_pessoais/models/transactions_model.dart';
import 'package:flutter/material.dart';

class TransactionsList extends ChangeNotifier {
  final List<TransactionsModel> _transactions = [];

  List<TransactionsModel> get transactions => [..._transactions];

  void addTransaction(TransactionsModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
