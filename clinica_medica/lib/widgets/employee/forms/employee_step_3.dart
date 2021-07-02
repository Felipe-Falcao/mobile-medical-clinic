import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:clinica_medica/widgets/employee/select_date_hiring_date.dart';

import 'package:flutter/material.dart';

class EmployeeStep3 extends StatelessWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;
  //final bool isValidDate;
  const EmployeeStep3(this._form, this._formData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: _form,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 32.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Dados Trabalhistas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    SelectDateHiringDate(_formData),
                    /*if (!isValidDate)
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  'Informe uma data válida',
                                  style: TextStyle(
                                      color: Colors.red[600], fontSize: 13),
                                ),
                              )
                            ],
                          )*/
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                  keyFormData: 'workCard',
                  formData: _formData,
                  labelText: 'Carteira de Trabalho',
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    bool isInvalid = value.trim().length < 11;
                    if (isEmpty || isInvalid) {
                      return 'Informe um número de carteira de trabalho válido';
                    }
                    return null;
                  }),
            )
          ],
        ),
      ),
    );
  }
}
