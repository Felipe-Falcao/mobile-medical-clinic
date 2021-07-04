import 'package:clinica_medica/models/specialty.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class DoctorStep4 extends StatefulWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;
  final bool _isEdit;

  const DoctorStep4(this._form, this._formData, this._isEdit);

  @override
  _DoctorStep4State createState() => _DoctorStep4State();
}

class _DoctorStep4State extends State<DoctorStep4> {
  //List<Specialty> _specialties = Specialty.getSpecialty();
  var _specialties = <Specialty>[
    Specialty(id: 1, name: 'Clinico Geral'),
    Specialty(id: 2, name: 'Ortopedista')
  ];

  List<DropdownMenuItem<Specialty>> _dropdownMenuItems;
  Specialty _selectedSpecialty;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_specialties);
    _selectedSpecialty = widget._formData['specialty'] != null
        ? widget._formData['specialt']
        : null;
    super.initState();
  }

  List<DropdownMenuItem<Specialty>> buildDropdownMenuItems(
      List<Specialty> specialties) {
    List<DropdownMenuItem<Specialty>> items = [];
    for (Specialty specialty in specialties) {
      items
          .add(DropdownMenuItem(value: specialty, child: Text(specialty.name)));
    }
    return items;
  }

  onChangedDropdownItem(Specialty selectedSpecialty) {
    setState(() {
      _selectedSpecialty = selectedSpecialty;
      widget._formData['specialty'] = selectedSpecialty;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _dropdownSpecialty() {
      return Container(
          margin: EdgeInsets.only(bottom: 16.0),
          width: 350,
          height: 48,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromRGBO(0, 21, 36, 0.11),
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  hint: widget._isEdit
                      ? null
                      : Text('Selecione uma especialidade'),
                  value: _selectedSpecialty,
                  onChanged: onChangedDropdownItem,
                  items: _dropdownMenuItems)));
    }

    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: widget._form,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 32.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Dados do Cargo de Médico',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                  keyFormData: 'crm',
                  formData: widget._formData,
                  labelText: 'CRM',
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    bool isInvalid = value.trim().length < 11;
                    if (isEmpty || isInvalid) {
                      return 'Informe um CRM válida';
                    }
                    return null;
                  }),
            ),
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
            Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: _dropdownSpecialty()),
          ],
        ),
      ),
    );
  }
}
