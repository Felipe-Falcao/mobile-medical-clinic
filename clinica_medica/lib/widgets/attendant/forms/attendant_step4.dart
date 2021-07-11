import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AttendantStep4 extends StatefulWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;
  final bool _isEdit;

  const AttendantStep4(this._form, this._formData, this._isEdit);

  @override
  _AttendantStep4State createState() => _AttendantStep4State();
}

class _AttendantStep4State extends State<AttendantStep4> {
  String currentOptionTurno;
  @override
  Widget build(BuildContext context) {
    Container _formFieldTurno() {
      return Container(
          //margin: EdgeInsets.only(bottom: 16.0),
          width: 350,
          height: 48,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromRGBO(0, 21, 36, 0.11),
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  hint: Text('Selecione uma turno'),
                  value: currentOptionTurno ?? widget._formData['rotation'],
                  onChanged: (String newValue) {
                    setState(() {
                      currentOptionTurno = newValue;
                      widget._formData['rotation'] = newValue;
                    });
                  },
                  items: <String>['Manhã', 'Tarde', 'Noite']
                      .map<DropdownMenuItem<String>>((String value) =>
                          DropdownMenuItem<String>(
                              value: value, child: Text(value)))
                      .toList())));
    }

    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: widget._form,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 24, bottom: 16.0),
                child: _formFieldTurno()),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                  keyFormData: 'salary',
                  formData: widget._formData,
                  labelText: 'Salário',
                  keyboardType: TextInputType.numberWithOptions(),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;

                    if (isEmpty) {
                      return 'Informe o salário';
                    }
                    return null;
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
