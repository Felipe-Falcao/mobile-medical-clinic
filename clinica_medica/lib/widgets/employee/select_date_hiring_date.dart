import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateHiringDate extends StatefulWidget {
  final Map<String, Object> _formData;

  const SelectDateHiringDate(this._formData);

  @override
  _SelectDateHiringDateState createState() => _SelectDateHiringDateState();
}

class _SelectDateHiringDateState extends State<SelectDateHiringDate> {
  String _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: widget._formData['hiringDate'] != null
            ? widget._formData['hiringDate']
            : DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    widget._formData['hiringDate'] = date;
    if (date != null) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedDate = widget._formData['hiringDate'] != null
        ? DateFormat('dd/MM/yyyy').format(widget._formData['hiringDate'])
        : 'Selecione a data de contratação';

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: TextButton(
        onPressed: () {
          _selectDate(context);
        },
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize: 14),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    _selectDate(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
