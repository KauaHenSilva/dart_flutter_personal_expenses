import 'package:dart_flutter_despesas_pessoais/models/transactions_list.dart';
import 'package:dart_flutter_despesas_pessoais/models/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

class TransactionsForm extends StatefulWidget {
  const TransactionsForm({super.key});

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _amountController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  void addTransaction() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final title = _formKey.currentState?.fields['title']?.value;
      final date = _formKey.currentState?.fields['date']?.value;
      final amount = _formKey.currentState?.fields['amount']?.value;

      final newTransaction = TransactionsModel(
        title: title,
        date: date,
        amount: amount,
      );

      final provider = Provider.of<TransactionsList>(context, listen: false);
      provider.addTransaction(newTransaction);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderDateTimePicker(
                name: 'date',
                decoration: const InputDecoration(labelText: 'Date'),
                inputType: InputType.date,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'amount',
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  (value) {
                    if (value != null) {
                      final amount = double.tryParse(
                        value.toString().replaceAll(RegExp(r'[^\d]'), ''),
                      );
                      if (amount == null || amount <= 0) {
                        return 'Invalid amount';
                      }
                    }
                    return null;
                  }
                ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
