import 'package:dart_flutter_despesas_pessoais/models/transactions_list.dart';
import 'package:dart_flutter_despesas_pessoais/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(icon: const Icon(Icons.bar_chart), onPressed: () {}),
        ],
      ),
      body: Consumer<TransactionsList>(
        builder: (context, transactionsList, child) {
          return transactionsList.transactions.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning),
                      Text('No transactions found'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: transactionsList.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactionsList.transactions[index];
                    return ListTile(
                      title: Text(transaction.title),
                      subtitle: Text(transaction.date.toString()),
                      trailing: Text(transaction.amount),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: const BottomAppBar(height: 50),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MyRoutes.addTransaction);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
