import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/providers/medical_chart/charts.dart';
import 'package:clinica_medica/widgets/medical_chart/popup_menu.dart';
import 'package:flutter/material.dart';
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
    if (!isLoading) {
      setState(() {
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
              setState(() {
                isLoading = true;
              });
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
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Informações do Prontuário',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: availableHeight * 0.22,
                    child: ListView.builder(
                      itemCount: chart.values().length,
                      itemBuilder: (ctx, i) => Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                chart.keys()[i],
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                chart.values()[i],
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
