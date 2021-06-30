import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/screens/medical_chart/detail_chart_screen.dart';
import 'package:clinica_medica/widgets/medical_chart/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChartItem extends StatelessWidget {
  final Chart chart;
  ChartItem({@required this.chart});

  @override
  Widget build(BuildContext context) {
    Charts charts = Provider.of<Charts>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailChartScreen(),
              settings: RouteSettings(arguments: chart)));
        },
        leading: CircleAvatar(
          child: Icon(
            Icons.note_alt_rounded,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(chart.patient.name),
        subtitle: Text(
            'Cadastro: ${DateFormat('dd/MM/yyyy').format(chart.entryDate)}'),
        trailing: PopupMenu(
          chart: chart,
          callback: (bool value) {
            if (value) {
              charts.removeChart(chart);
            }
          },
        ),
      ),
    );
  }
}
