import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medical_chart/chart_item.dart';
import 'package:clinica_medica/widgets/new_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindChartScreen extends StatefulWidget {
  @override
  _FindChartScreenState createState() => _FindChartScreenState();
}

class _FindChartScreenState extends State<FindChartScreen> {
  final _formData = Map<String, Object>();
  String _filter;

  @override
  Widget build(BuildContext context) {
    _filter = _formData['filter'];
    final Charts chartsProvider = Provider.of<Charts>(context);
    final Patients patients = Provider.of<Patients>(context, listen: false);
    final List<Chart> charts =
        chartsProvider.getItemsWith(_filter, patients.items);

    final appBar = AppBar(
      title: const Text('Prontuários'),
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
                itemCount: charts.length,
                itemBuilder: (ctx, i) => ChartItem(chart: charts[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
