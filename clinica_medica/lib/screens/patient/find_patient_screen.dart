import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patient/patients.dart';
import 'package:clinica_medica/widgets/patient/forms/new_text_form_field.dart';
import 'package:clinica_medica/widgets/patient/patient_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPatientScreen extends StatefulWidget {
  @override
  _FindPatientScreenState createState() => _FindPatientScreenState();
}

class _FindPatientScreenState extends State<FindPatientScreen> {
  final _formData = Map<String, Object>();
  String _filter;

  @override
  Widget build(BuildContext context) {
    _filter = _formData['filter'] != null ? _formData['filter'] : null;
    final Patients patientsProvider = Provider.of<Patients>(context);
    final List<Patient> patients = patientsProvider.getItemsWith(_filter);

    final appBar = AppBar(
      centerTitle: true,
      title: const Text('Pacientes'),
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: NewTextFormField(
                  keyFormData: 'filter',
                  formData: _formData,
                  labelText: 'Nome ou CPF',
                  onChanged: (value) {
                    setState(() {
                      _filter = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: availableHeight - 90,
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (ctx, i) => PatientItem(patient: patients[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
