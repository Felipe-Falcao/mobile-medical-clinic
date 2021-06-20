import 'package:clinica_medica/providers/medical_chart/charts.dart';
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
    _filter = _formData['filter'] != null ? _formData['filter'] : null;
    final Charts chartsProvider = Provider.of<Charts>(context);
    // final List<Charts> patients = patientsProvider.getItemsWith(_filter);

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
                itemCount: chartsProvider.items.length,
                itemBuilder: (ctx, i) =>
                    ChartItem(chart: chartsProvider.items[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
