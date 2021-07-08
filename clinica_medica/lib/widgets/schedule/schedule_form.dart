import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/widgets/medical_appointment/select_date.dart';
import 'package:clinica_medica/widgets/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleForm extends StatefulWidget {
  final GlobalKey<FormState> form;
  final Map<String, Object> formData;
  final bool isValidDate;
  final bool isValidDoctor;
  final Function callback;

  const ScheduleForm({
    @required this.formData,
    @required this.form,
    @required this.isValidDate,
    @required this.isValidDoctor,
    @required this.callback,
  });

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  Doctor doctorSelected;

  @override
  Widget build(BuildContext context) {
    final doctors = Provider.of<DoctorProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: widget.form,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            _searchableDropdown(
              items: doctors.items,
              key: 'doctorId',
              label: 'Selecione o médico',
              selected: doctorSelected,
            ),
            const SizedBox(height: 12),
            SelectDate(widget.formData, widget.callback),
          ],
        ),
      ),
    );
  }

  Widget _searchableDropdown(
      {List<dynamic> items, String key, String label, dynamic selected}) {
    return Container(
      height: 38,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: SearchableDropdown(
        key: ValueKey(key),
        hint: Text(label),
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        items: items.map((item) {
          return new DropdownMenuItemDiff<Object>(
              child: Text(item.employee.name), value: item);
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
        value: selected,
        searchHint: new Text(
          'Selecione',
          style: new TextStyle(fontSize: 20),
        ),
        onChanged: (value) {
          setState(() {
            widget.formData[key] = value.id;
            selected = value;
            widget.callback();
          });
        },
      ),
    );
  }
}
