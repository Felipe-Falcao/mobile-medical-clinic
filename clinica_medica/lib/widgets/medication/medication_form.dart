import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../searchable_dropdown.dart';

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
  Patient patientSelected;

  @override
  void initState() {
    Patients patients = Provider.of<Patients>(context, listen: false);

    setState(() {
      patientSelected = widget.formData['refPaciente'] != null
          ? patients.getItemById(widget.formData['refPaciente'])
          : null;
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
            _searchableDropdown(
              items: patients.items,
              key: 'refPaciente',
              label: 'Selecione o paciente',
              patientSelected: patientSelected,
            ),
            if (!widget.isValidMedication)
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Nenhum paciente selecionado!',
                      style: TextStyle(color: Colors.red[600], fontSize: 13),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            CustomTextFormField(
                keyFormData: 'nome',
                formData: widget.formData,
                labelText: 'Nome do Medicamento',
                autofocus: true,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 3;
                  if (isEmpty || isInvalid) {
                    return 'Informe um nome válido\ncom no mínimo 3 caracteres!';
                  }
                  return null;
                }),
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

  Widget _searchableDropdown(
      {List<dynamic> items,
      String key,
      String label,
      Patient patientSelected}) {
    final isEditing = widget.currentMode == 'Editar Receita';
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).inputDecorationTheme.fillColor,
      ),
      child: SearchableDropdown(
        key: ValueKey(key),
        readOnly: isEditing,
        iconSize: 30,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(label),
        ),
        style: !isEditing
            ? TextStyle(fontSize: 15, color: Colors.black87)
            : TextStyle(fontSize: 15, color: Colors.black38),
        underline: SizedBox(),
        items: items.map((item) {
          return new DropdownMenuItemDiff<dynamic>(
              child: Text(item.name), value: item);
        }).toList(),
        searchFn: (String keyword, items) {
          List<int> ret = [];
          if (keyword != null && items != null && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              items.forEach((item) {
                if (k.isNotEmpty &&
                    (item.value.name
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  ret.add(i);
                }
                i++;
              });
            });
          }
          if (keyword.isEmpty) {
            ret = Iterable<int>.generate(items.length).toList();
          }
          return (ret);
        },
        closeButton: 'Fechar',
        isExpanded: true,
        value: patientSelected,
        searchHint: new Text(
          'Selecione',
          style: new TextStyle(fontSize: 20),
        ),
        onChanged: (value) {
          setState(() {
            widget.formData[key] = value.id;
            patientSelected = value;
          });
        },
      ),
    );
  }
}
