import 'package:clinica_medica/widgets/patient/select_date.dart';
import 'package:flutter/material.dart';

import 'new_text_form_field.dart';

class PatientFormStep1 extends StatelessWidget {
  final GlobalKey<FormState> form;
  final Map<String, Object> formData;
  final bool isValidDate;

  const PatientFormStep1({
    @required this.formData,
    @required this.form,
    @required this.isValidDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: form,
        child: Column(
          children: <Widget>[
            NewTextFormField(
                keyFormData: 'name',
                formData: formData,
                labelText: 'Nome',
                autofocus: true,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 3;
                  if (isEmpty || isInvalid) {
                    return 'Informe um nome válido com no mínimo 3 caracteres!';
                  }
                  return null;
                }),
            const SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: NewTextFormField(
                    keyFormData: 'phoneNumber',
                    formData: formData,
                    labelText: 'Telefone',
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      bool isEmpty = value.trim().isEmpty;
                      bool isInvalid = value.trim().length < 9;
                      if (isEmpty || isInvalid) {
                        return 'Informe um número de telefone válido!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            NewTextFormField(
              keyFormData: 'cpf',
              formData: formData,
              labelText: 'CPF',
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                bool isEmpty = value.trim().isEmpty;
                bool isInvalid = value.trim().length < 11;
                if (isEmpty || isInvalid) {
                  return 'Informe um CPF válido com no mínimo 11 caracteres!';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            SelectDate(formData),
            if (!isValidDate)
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Informe uma data válida!',
                      style: TextStyle(color: Colors.red[600], fontSize: 13),
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
