import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/receita.dart';
import 'package:clinica_medica/providers/medication_provider.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/screens/medical_chart/detail_chart_screen.dart';
import 'package:clinica_medica/widgets/medication/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MedicationItem extends StatelessWidget {
  final Receita receita;
  MedicationItem({@required this.receita});

  @override
  Widget build(BuildContext context) {
    Patient patient = Provider.of<Patients>(context, listen: false)
        .getItemById(receita.refPaciente);
    Medication medication = Provider.of<Medication>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailChartScreen(),
              settings: RouteSettings(arguments: receita)));
        },
        leading: CircleAvatar(
          child: Icon(
            Icons.note_alt_rounded,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(patient.name),
        subtitle: Text(
            'Data Pescrição: ${DateFormat('dd/MM/yyyy').format(receita.dataPrescricao)}'),
        trailing: ReceitaMenu(
          receita: receita,
          callback: (bool value) {
            if (value) {
              medication.removeMedication(receita);
            }
          },
        ),
      ),
    );
  }
}
