import 'package:brasil_fields/brasil_fields.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmployeeStep2 extends StatelessWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;

  const EmployeeStep2(this._form, this._formData);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 24, bottom: 16.0),
                child: CustomTextFormField(
                    keyFormData: 'street',
                    formData: _formData,
                    labelText: 'Logradouro',
                    validator: (value) {
                      bool isEmpty = value.trim().isEmpty;
                      bool isInvalid = value.trim().length < 3;
                      if (isEmpty || isInvalid) {
                        return 'Informe um logradouro válido com no mínimo 3 caracteres!';
                      }
                      return null;
                    }),
              ),
              Row(
                children: [
                  SizedBox(
                      width: 150,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: CustomTextFormField(
                            keyFormData: 'number',
                            formData: _formData,
                            labelText: 'Número',
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;

                              if (isEmpty) {
                                return 'Informe um número válido';
                              }
                              return null;
                            }),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: 150,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: CustomTextFormField(
                          keyFormData: 'zipCode',
                          formData: _formData,
                          labelText: 'CEP',
                          //keyboardType: TextInputType.numberWithOptions(),
                          validator: (value) {
                            bool isEmpty = value.trim().isEmpty;
                            bool isInvalid = value.trim().length < 8;
                            if (isEmpty || isInvalid) {
                              return 'Informe um CEP válido!';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 150,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: CustomTextFormField(
                            keyFormData: 'city',
                            formData: _formData,
                            labelText: 'Cidade',
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;

                              if (isEmpty) {
                                return 'Informe um nome de cidade válido!';
                              }
                              return null;
                            }),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: 150,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: CustomTextFormField(
                            keyFormData: 'state',
                            formData: _formData,
                            labelText: 'Estado',
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              bool isInvalid = value.trim().length < 3;
                              if (isEmpty || isInvalid) {
                                return 'Informe um nome de estado válido!';
                              }
                              return null;
                            }),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
