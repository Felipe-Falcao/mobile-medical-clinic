import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medical_chart/select_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ChartForm extends StatefulWidget {
  final GlobalKey<FormState> form;
  final Map<String, Object> formData;
  final bool isValidDate;
  final bool isValidPatient;

  const ChartForm({
    @required this.formData,
    @required this.form,
    @required this.isValidDate,
    @required this.isValidPatient,
  });

  @override
  _ChartFormState createState() => _ChartFormState();
}

class _ChartFormState extends State<ChartForm> {
  Patient selectedValue;

  @override
  void initState() {
    if (widget.formData['patient'] != null)
      setState(() {
        selectedValue = widget.formData['patient'];
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Patients patients = Provider.of<Patients>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Form(
        key: widget.form,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              child: SearchableDropdown(
                key: ValueKey('patient'),
                iconSize: 30,
                hint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Selecione"),
                ),
                style: TextStyle(fontSize: 15, color: Colors.black87),
                underline: SizedBox(),
                items: patients.items.map((item) {
                  return new DropdownMenuItem<Patient>(
                      child: Text(item.name), value: item);
                }).toList(),
                closeButton: 'Fechar',
                isExpanded: true,
                isCaseSensitiveSearch: false,
                value: selectedValue,
                searchHint: new Text(
                  'Selecione ',
                  style: new TextStyle(fontSize: 20),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    widget.formData['patient'] = selectedValue;
                  });
                },
              ),
            ),
            if (!widget.isValidPatient)
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Selecione um paciente!',
                      style: TextStyle(color: Colors.red[600], fontSize: 13),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            SelectDate(widget.formData),
            if (!widget.isValidDate)
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
            TextFormField(
              key: ValueKey('note'),
              autofocus: true,
              initialValue: widget.formData['note'],
              maxLines: 10,
              minLines: 4,
              decoration: InputDecoration(
                labelText: 'Nota',
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
              onChanged: (value) => widget.formData['note'] = value,
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
