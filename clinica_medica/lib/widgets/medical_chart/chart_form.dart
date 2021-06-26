import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medical_chart/select_date.dart';
import 'package:clinica_medica/widgets/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartForm extends StatefulWidget {
  final GlobalKey<FormState> form;
  final Map<String, Object> formData;
  final bool isValidDate;
  final bool isValidPatient;
  final String currentMode;

  const ChartForm({
    @required this.formData,
    @required this.form,
    @required this.isValidDate,
    @required this.isValidPatient,
    @required this.currentMode,
  });

  @override
  _ChartFormState createState() => _ChartFormState();
}

class _ChartFormState extends State<ChartForm> {
  Patient patientSelected;

  @override
  void initState() {
    setState(() {
      patientSelected = widget.formData['patient'];
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
              key: 'patient',
              label: 'Selecione o paciente',
              patientSelected: patientSelected,
            ),
            if (!widget.isValidPatient)
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

  Widget _searchableDropdown(
      {List<dynamic> items,
      String key,
      String label,
      Patient patientSelected}) {
    final isEditing = widget.currentMode == 'Editar Prontuário';
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
            widget.formData[key] = value;
            patientSelected = value;
          });
        },
      ),
    );
  }
}
