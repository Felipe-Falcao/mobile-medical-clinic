import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MedicationForm extends StatefulWidget {
  final GlobalKey<FormState> form;
  final Map<String, Object> formData;
  final bool isValidMedication;
  final String currentMode;

  const MedicationForm({
    @required this.formData,
    @required this.form,
    @required this.isValidMedication,
    @required this.currentMode,
  });

  @override
  _MedicationFormState createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: widget.form,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            TextFormField(
              key: ValueKey('dose'),
              initialValue: widget.formData['dose'],
              maxLines: 10,
              minLines: 4,
              decoration: InputDecoration(
                labelText: 'Dose',
                labelStyle: TextStyle(fontSize: 14.0, color: Colors.black54),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border: const OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              textInputAction: TextInputAction.next,
              onChanged: (value) => widget.formData['dose'] = value,
              validator: (value) {
                bool isEmpty = value.trim().isEmpty;
                bool isInvalid = value.trim().length < 10;
                if (isEmpty || isInvalid) {
                  return 'Informe uma descrição válido com no mínimo 10 caracteres!';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
