import 'package:flutter/material.dart';

import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter application', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> userTransaction = [
    Transaction(
        id: 't1', title: 'crytpo', amount: 110000, date: DateTime.now()),
    Transaction(id: 't2', title: 'stocks', amount: 210000, date: DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.black45,
                elevation: 10,
                child: Text('This is the chart'),
              ),
            ),
            Column(
                children: userTransaction.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(tx.amount.toString()),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87, width: 1)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(tx.title),
                        Text(tx.date.toString())
                      ],
                    )
                  ],
                ),
              );
            }).toList())
          ],
        ));
  }
}
