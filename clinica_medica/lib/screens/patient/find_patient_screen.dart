import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/new_text_form_field.dart';
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
    _filter = _formData['filter'];
    final Patients patientsProvider = Provider.of<Patients>(context);
    final List<Patient> patients = patientsProvider.getItemsWith(_filter);

    final appBar = AppBar(
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
                child: Stack(children: [
                  Positioned(
                      child: Icon(Icons.search_rounded), right: 14, top: 14),
                  NewTextFormField(
                    keyFormData: 'filter',
                    formData: _formData,
                    labelText: 'Nome ou CPF',
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                  ),
                ]),
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
