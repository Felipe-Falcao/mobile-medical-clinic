import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';

import 'package:flutter/material.dart';

class EmployeeStep1 extends StatelessWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;

  const EmployeeStep1(this._form, this._formData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, right: 20, left: 20),
      child: Form(
        key: _form,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 22.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Dados Pessoais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
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
                  }),
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
                  validator: _validarCPF),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: CustomTextFormField(
                  keyFormData: 'password',
                  formData: _formData,
                  labelText: 'Informe uma senha',
                  obscureText: true,
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    bool isInvalid = value.trim().length < 9;
                    if (isEmpty || isInvalid) {
                      return 'Informe uma senha com 9 caracteres';
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
                  if (value != _formData['password']) {
                    return 'As senhas são diferente';
                  }
                },
              ),
            ),
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

  String _validarCPF(String value) {
    String pattern =
        '([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return 'Informe o CPF';
    } else if (!regExp.hasMatch(value)) {
      return 'CPF inválido';
    } else {
      return null;
    }
  }

  /*String _validarSenha(String value) {
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return 'Informe uma senha';
    } else if (!regExp.hasMatch(value)) {
      return 'A senha deve ter:\n 8 digitos\n uma letra maiúscula\n uma letra minúscula\n um número\n um caracter especial\n';
    } else {
      return null;
    }
  }*/
}
