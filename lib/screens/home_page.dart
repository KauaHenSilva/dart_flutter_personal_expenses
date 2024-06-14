import 'package:dart_flutter_despesas_pessoais/models/transactions_list.dart';
import 'package:dart_flutter_despesas_pessoais/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _fetchTransactions;

  Future<void> _fetchTransactionsList() async {
    final transactionsList = context.read<TransactionsList>();
    transactionsList.fetchTransactions();
  }

  Future<void> refreshTransactionsList() async {
    setState(() {
      _fetchTransactions = _fetchTransactionsList();
    });
    await _fetchTransactions;
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactions = refreshTransactionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () {
                Navigator.of(context).pushNamed(MyRoutes.graphic);
              }),
        ],
      ),
      body: Consumer<TransactionsList>(
        builder: (context, transactionsList, child) {
          return FutureBuilder(
            future: _fetchTransactions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error on request'));
              }

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
                        final transaction =
                            transactionsList.transactions[index];
                        return Card(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.purple,
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'R\$${transaction.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction.title),
                                  Text(transaction.date.toString()),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  transactionsList
                                      .removeTransaction(transaction.id);
                                },
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        );
                      },
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
