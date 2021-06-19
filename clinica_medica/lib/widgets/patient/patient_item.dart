import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patient/patients.dart';
import 'package:clinica_medica/screens/patient/detail_patient_screen.dart';
import 'package:clinica_medica/widgets/patient/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  PatientItem({@required this.patient});
  @override
  Widget build(BuildContext context) {
    Patients patients = Provider.of<Patients>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPatientScreen(),
              settings: RouteSettings(arguments: patient)));
        },
        leading: CircleAvatar(
          child: Text(
            '${patient.name[0]}',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(patient.name),
        subtitle: Text('CPF: ${patient.cpf}'),
        trailing: PopupMenu(
          patient: patient,
          callback: (bool value) {
            if (value) {
              patients.removePatient(patient);
            }
          },
        ),
      ),
    );
  }
}
