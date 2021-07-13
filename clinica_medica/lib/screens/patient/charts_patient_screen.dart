import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/screens/medical_chart/detail_chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/*
* Responsavel por renderizar a tela com a lista de prontuarios
* para o paciente selecionado.
*/
class ChartsPatientScreen extends StatelessWidget {
  final Patient patient;
  const ChartsPatientScreen(this.patient);

  @override
  Widget build(BuildContext context) {
    Charts charts = Provider.of<Charts>(context);
    List<Chart> filteredCharts =
        charts.items.where((chart) => chart.patientId == patient.id).toList();

    return Scaffold(
      appBar: AppBar(title: Text(patient.name)),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: filteredCharts.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Prontuarios',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredCharts
                          .map((chart) => _chartItem(context, chart))
                          .toList(),
                    )
                  ],
                )
              : Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text('Não há prontuários cadastrado'),
                    ],
                  ),
                )),
    );
  }

  Widget _chartItem(BuildContext context, Chart chart) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.note_alt,
            color: Theme.of(context).accentColor,
          ),
        ),
        title: Text(DateFormat('dd/MM/yyyy').format(chart.entryDate)),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailChartScreen(),
              settings: RouteSettings(arguments: chart)));
        },
      ),
    );
  }
}
