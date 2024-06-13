import 'package:dart_flutter_despesas_pessoais/models/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphicPage extends StatelessWidget {
  const GraphicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphic Page'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Consumer<TransactionsList>(
          builder: (context, transactionList, child) {
            final weeklyAmounts = transactionList.getWeeklyAmounts;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: constraints.maxHeight * 0.1,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                'R\$${weeklyAmounts[index].toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                            height: constraints.maxHeight * 0.8,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: constraints.maxHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border:
                                        Border.all(color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Container(
                                  height: constraints.maxHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    border:
                                        Border.all(color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: constraints.maxHeight * 0.1,
                            child: Text(
                              [
                                'Sun',
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat'
                              ][index],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
