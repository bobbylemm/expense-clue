import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Widget _showTextField(String placeholder, TextEditingController controller,
      TextInputType keyBoardType, Function onSubmit) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: CupertinoTextField(
              placeholder: placeholder,
              controller: controller,
            ),
          )
        : TextField(
            decoration: InputDecoration(
              labelText: placeholder,
            ),
            controller: controller,
            keyboardType: Platform.isIOS && keyBoardType == TextInputType.number
                ? TextInputType.numberWithOptions(signed: true, decimal: true)
                : keyBoardType,
            onSubmitted: (_) => onSubmit());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _showTextField('expense title', _titleController,
                  TextInputType.text, () => null),
              _showTextField('expense amount', _amountController,
                  TextInputType.number, _submitData),
              Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen yet'
                            : 'Picked date ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose date', _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).textTheme.button.color,
                elevation: 0,
                child: const Text('Add expense'),
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
