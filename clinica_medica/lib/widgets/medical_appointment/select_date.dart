import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  final _formData;
  final Function callback;
  const SelectDate(this._formData, this.callback);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  String _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: widget._formData['date'] ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            accentColor: Theme.of(context).accentColor,
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.black,
              surface: Colors.pink,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    widget._formData['date'] = d;
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat('dd/MM/yyyy').format(d);
      });
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    _selectedDate = widget._formData['date'] != null
        ? new DateFormat('dd/MM/yyyy').format(widget._formData['date'])
        : 'Selecione uma data';

    return Container(
      height: 38,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: TextButton(
        onPressed: () {
          _selectDate(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget._formData['date'] == null
                  ? Text(_selectedDate, style: TextStyle(color: Colors.black45))
                  : Text(_selectedDate,
                      style: TextStyle(color: Colors.black87, fontSize: 13)),
              IconButton(
                padding: EdgeInsets.all(0),
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.calendar_today, size: 16),
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
