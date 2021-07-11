import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/screens/patient/detail_patient_screen.dart';
import 'package:clinica_medica/widgets/patient/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  PatientItem({@required this.patient});
  @override
  Widget build(BuildContext context) {
    Patients patients = Provider.of<Patients>(context, listen: false);
    Charts charts = Provider.of<Charts>(context, listen: false);
    Appointments appointments =
        Provider.of<Appointments>(context, listen: false);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPatientScreen(),
              settings: RouteSettings(arguments: patient)));
        },
        leading: CircleAvatar(
          child: Icon(Icons.person, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(patient.name),
        subtitle: Text('CPF: ${patient.cpf}'),
        trailing: PopupMenu(
          patient: patient,
          callback: (bool value) {
            if (value) {
              appointments.removeAppointmentsWith(patient.id).then(
                    (value) => charts.removeChartsWith(patient.id).then(
                          (_) => patients.removePatient(patient),
                        ),
                  );
            }
          },
        ),
      ),
    );
  }
}
