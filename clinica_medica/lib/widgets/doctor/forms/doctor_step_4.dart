import 'package:clinica_medica/controllers/funcionario_controller.dart';
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
  String currentOptionEspecialidade;
  FuncionarioController funcionarioController = FuncionarioController();

  List<Specialty> specialties = [];

  Future<void> loadSpecialties() async {
    List<dynamic> specialtyList =
        await funcionarioController.buscarEspecialidades();

    specialties.clear();

    for (var i = 0; i < specialtyList.length; i++) {
      Specialty specialty = Specialty(
          id: specialtyList[i]['id'],
          name: specialtyList[i]['nomeEspecialidade']);

      specialties.add(specialty);
    }
  }

  @override
  Widget build(BuildContext context) {
    loadSpecialties();

    Container _formFieldEspecialidade(List<Specialty> especialidades) {
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
              child: DropdownButton<String>(
                  hint: Text('Selecione uma especialidade'),
                  value: currentOptionEspecialidade,
                  onChanged: (String newValue) {
                    setState(() {
                      currentOptionEspecialidade = newValue;
                      widget._formData['specialty_name'] = newValue;
                    });
                  },
                  items: especialidades
                      .map<DropdownMenuItem<String>>((Specialty value) =>
                          DropdownMenuItem<String>(
                              value: value.name, child: Text(value.name)))
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
                child: _formFieldEspecialidade(specialties)),
          ],
        ),
      ),
    );
  }
}
