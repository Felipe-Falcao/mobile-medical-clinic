import 'package:flutter/material.dart';

import 'new_text_form_field.dart';

class PatientFormStep2 extends StatelessWidget {
  final GlobalKey<FormState> _form;
  final Map<String, Object> _formData;

  const PatientFormStep2(this._formData, this._form);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            NewTextFormField(
              keyFormData: 'street',
              labelText: 'Logradouro',
              formData: _formData,
              autofocus: true,
              validator: (value) {
                bool isEmpty = value.trim().isEmpty;
                bool isInvalid = value.trim().length < 3;
                if (isEmpty || isInvalid) {
                  return 'Informe um Logradouro válido com no mínimo 3 caracteres!';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 120,
                  child: NewTextFormField(
                    keyFormData: 'number',
                    labelText: 'Número',
                    formData: _formData,
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      bool isEmpty = value.trim().isEmpty;
                      if (isEmpty) {
                        return 'Informe um número válido!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 170,
                  child: NewTextFormField(
                    keyFormData: 'zipCode',
                    labelText: 'CEP',
                    formData: _formData,
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      bool isEmpty = value.trim().isEmpty;
                      bool isInvalid = value.trim().length < 8;

                      if (isEmpty || isInvalid) {
                        return 'Informe um CEP válido!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: NewTextFormField(
                    keyFormData: 'city',
                    labelText: 'Cidade',
                    formData: _formData,
                    validator: (value) {
                      bool isEmpty = value.trim().isEmpty;
                      if (isEmpty) {
                        return 'Informe uma cidade válida!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: NewTextFormField(
                    keyFormData: 'state',
                    labelText: 'Estado',
                    formData: _formData,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      bool isEmpty = value.trim().isEmpty;
                      bool isInvalid = value.trim().length < 3;
                      if (isEmpty || isInvalid) {
                        return 'Informe um estado válido!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
