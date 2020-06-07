import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupWeeklyTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSumForWeek = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSumForWeek += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSumForWeek);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSumForWeek
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupWeeklyTransactions.fold(0.0, (sum, element) {
      return sum += element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupWeeklyTransactions);
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColorDark, width: .4),
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupWeeklyTransactions.map((data) {
            return Expanded(
              child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPercentTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
