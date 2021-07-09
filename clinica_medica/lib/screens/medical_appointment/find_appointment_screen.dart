import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medical_appointment/appointment_item.dart';
import 'package:clinica_medica/widgets/new_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindAppointmentScreen extends StatefulWidget {
  @override
  _FindAppointmentScreenState createState() => _FindAppointmentScreenState();
}

class _FindAppointmentScreenState extends State<FindAppointmentScreen> {
  final _formData = Map<String, Object>();
  String _filter;

  @override
  Widget build(BuildContext context) {
    _filter = _formData['filter'];
    Appointments appointmentProvider = Provider.of<Appointments>(context);
    List<Patient> patients =
        Provider.of<Patients>(context, listen: false).items;
    List<Appointment> appointments =
        appointmentProvider.getItemsWith(_filter, patients);

    final appBar = AppBar(
      title: const Text('Buscar Consultas'),
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
                      setState(() => _filter = value);
                    },
                  ),
                ]),
              ),
            ),
            Container(
              height: availableHeight - 90,
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (ctx, i) =>
                    AppointmentItem(appointment: appointments[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
