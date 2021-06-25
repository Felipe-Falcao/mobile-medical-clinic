import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medical_appointment/select_date.dart';
import 'package:clinica_medica/widgets/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentForm extends StatefulWidget {
  final GlobalKey<FormState> form;
  final Map<String, Object> formData;
  final bool isValidDate;
  final bool isValidPatient;
  final bool isValidDoctor;

  const AppointmentForm({
    @required this.formData,
    @required this.form,
    @required this.isValidDate,
    @required this.isValidPatient,
    @required this.isValidDoctor,
  });

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  List<Doctor> doctors = [
    Doctor(name: 'Paulo', CRM: 'crm-teste', id: 'idteste', salary: 500),
    Doctor(name: 'Carlos', CRM: 'crm-teste2', id: 'idteste2', salary: 500),
  ];

  @override
  Widget build(BuildContext context) {
    Patients patients = Provider.of<Patients>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: widget.form,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            _searchableDropdown(
                patients.items, 'patient', 'Selecione o paciente'),
            if (!widget.isValidPatient)
              Row(children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Selecione um paciente!',
                        style: TextStyle(color: Colors.red[600], fontSize: 13)))
              ]),
            const SizedBox(height: 12),
            _searchableDropdown(doctors, 'doctor', 'Selecione o médico'),
            if (!widget.isValidPatient)
              Row(children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Selecione um médico!',
                        style: TextStyle(color: Colors.red[600], fontSize: 13)))
              ]),
            const SizedBox(height: 12),
            SelectDate(widget.formData),
            if (!widget.isValidDate)
              Row(children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Informe uma data válida!',
                        style: TextStyle(color: Colors.red[600], fontSize: 13)))
              ]),
          ],
        ),
      ),
    );
  }

  Widget _searchableDropdown(List<dynamic> items, String key, String label) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.7, color: Theme.of(context).accentColor),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        // color: Theme.of(context).inputDecorationTheme.fillColor,
      ),
      child: SearchableDropdown(
        key: ValueKey(key),
        hint: Text(label),
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        items: items.map((item) {
          return new DropdownMenuItemDiff<Object>(
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
        value: widget.formData[key],
        searchHint: new Text(
          'Selecione',
          style: new TextStyle(fontSize: 20),
        ),
        onChanged: (value) {
          setState(() {
            widget.formData[key] = value;
          });
        },
      ),
    );
  }
}
