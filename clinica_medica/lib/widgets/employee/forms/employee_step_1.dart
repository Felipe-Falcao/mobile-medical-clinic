import 'package:brasil_fields/brasil_fields.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmployeeStep1 extends StatelessWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;
  final bool _isEdit;

  const EmployeeStep1(this._form, this._formData, this._isEdit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, right: 20, left: 20),
      child: Form(
        key: _form,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 16.0),
              child: CustomTextFormField(
                  keyFormData: 'name',
                  formData: _formData,
                  labelText: 'Nome',
                  autofocus: true,
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    bool isInvalid = value.trim().length < 3;
                    if (isEmpty || isInvalid) {
                      return 'Informe um nome válido\ncom no mínimo 3 caracteres!';
                    }
                    return null;
                  }),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                keyFormData: 'phoneNumber',
                formData: _formData,
                labelText: 'Telefone',
                keyboardType: TextInputType.numberWithOptions(),
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 9;
                  if (isEmpty || isInvalid) {
                    return 'Informe um número de telefone válido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                  keyFormData: 'email',
                  formData: _formData,
                  labelText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validarEmail),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                keyFormData: 'cpf',
                formData: _formData,
                labelText: 'CPF',
                keyboardType: TextInputType.numberWithOptions(),
                validator: (value) {
                  if (!UtilBrasilFields.isCPFValido(value)) {
                    return 'Informe um CPF válido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
              ),
            ),
            !_isEdit
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: CustomTextFormField(
                            keyFormData: 'password',
                            formData: _formData,
                            labelText: 'Informe uma senha',
                            obscureText: true,
                            validator: (value) {
                              if (!_isEdit) {
                                bool isEmpty = value.trim().isEmpty;
                                bool isInvalid = value.trim().length < 9;
                                if (isEmpty || isInvalid) {
                                  return 'Informe uma senha com 9 caracteres';
                                }
                              }

                              return null;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: CustomTextFormField(
                          keyFormData: 'passwordConfirmation',
                          formData: _formData,
                          labelText: 'Confirme sua senha',
                          obscureText: true,
                          validator: (value) {
                            if (!_isEdit) {
                              if (value != _formData['password']) {
                                return 'As senhas são diferente';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  String _validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Informe um Email';
    } else if (!regExp.hasMatch(value)) {
      return 'Email inválido';
    } else {
      return null;
    }
  }
}
