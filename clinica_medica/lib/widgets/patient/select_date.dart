import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  final _formData;

  const SelectDate(this._formData);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  String _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: widget._formData['birthDate'] != null
          ? widget._formData['birthDate']
          : DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      // lastDate: DateTime(2022),
    );
    widget._formData['birthDate'] = d;
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat('dd/MM/yyyy').format(d);
      });
  }

  @override
  Widget build(BuildContext context) {
    _selectedDate = widget._formData['birthDate'] != null
        ? new DateFormat('dd/MM/yyyy').format(widget._formData['birthDate'])
        : 'Seleciona a data de nascimento';

    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: TextButton(
        onPressed: () {
          _selectDate(context);
        },
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _selectedDate,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
