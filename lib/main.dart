import 'package:flutter/material.dart';
import 'package:save_your_money/widgets/tansaction_list.dart';

import './widgets/new_transaction.dart';
import './widgets/tansaction_list.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app1',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'New shoes', amount: 70, date: DateTime.now()),
    Transaction(id: 't2', title: 'New bag', amount: 69, date: DateTime.now()),
    Transaction(id: 't1', title: 'New shoes', amount: 70, date: DateTime.now()),
    Transaction(id: 't2', title: 'New bag', amount: 69, date: DateTime.now()),
    Transaction(id: 't1', title: 'New shoes', amount: 70, date: DateTime.now()),
    Transaction(id: 't2', title: 'New bag', amount: 69, date: DateTime.now()),
    Transaction(id: 't1', title: 'New shoes', amount: 70, date: DateTime.now()),
    Transaction(id: 't2', title: 'New bag', amount: 69, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dt) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: dt,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        //function to return a widget
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save My Money!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
