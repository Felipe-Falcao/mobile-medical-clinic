import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Classe que cria um seletor de datas customizado para
//o cadastro de médico e atendente
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
        initialDate: widget._formData['hiringDate'] ?? DateTime.now(),
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
              widget._formData['hiringDate'] != null
                  ? Text(
                      _selectedDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    )
                  : Text(
                      _selectedDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87),
                    ),
              IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
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
