import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medical_chart/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailChartScreen extends StatefulWidget {
  @override
  _DetailChartScreenState createState() => _DetailChartScreenState();
}

class _DetailChartScreenState extends State<DetailChartScreen> {
  Chart chart;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    chart = ModalRoute.of(context).settings.arguments as Chart;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Charts charts = Provider.of<Charts>(context);
    Patient patient = Provider.of<Patients>(context, listen: false)
        .getItemById(chart.patientId);

    if (!isLoading) {
      setState(() {
        //atualiza o prontuario apos edicao
        chart = charts.getItemById(chart.id);
      });
    }

    final appBar = AppBar(
      title: const Text('Prontuário'),
      actions: [
        PopupMenu(
          chart: chart,
          callback: (bool value) {
            if (value) {
              setState(() => isLoading = true);
              Navigator.of(context).pop();
              charts.removeChart(chart);
            }
          },
          icon: Icon(Icons.more_vert_rounded),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Informações do Prontuário',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const Divider(height: 10),
                  Container(
                    height: availableHeight - 70,
                    child: Column(
                      children: [
                        _itemList('Paciente', patient.name),
                        _itemList(
                          'Data de cadastro',
                          new DateFormat('dd/MM/yyyy').format(chart.entryDate),
                        ),
                        _itemList(
                          'Data de atualização',
                          new DateFormat('dd/MM/yyyy').format(chart.updateDate),
                        ),
                        _itemList('Nota', ''),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              chart.note,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _itemList(String key, String value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(key, style: TextStyle(color: Colors.black54)),
          ),
          Container(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value,
                  style: TextStyle(color: Theme.of(context).accentColor)),
            ),
          ),
        ],
      ),
    );
  }
}
