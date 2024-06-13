import 'package:flutter/material.dart';

class TransactionsForm extends StatelessWidget {
const TransactionsForm({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: const Center(
        child: Text('Form goes here'),
      ),
    );
  }
}