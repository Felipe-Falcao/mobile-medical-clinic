import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/providers/medical_chart/charts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/medical_chart/chart_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterChartScreen extends StatefulWidget {
  @override
  _RegisterChartScreenState createState() => _RegisterChartScreenState();
}

class _RegisterChartScreenState extends State<RegisterChartScreen> {
  String _titleScreen = 'Cadastrar Prontuário';
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isValidDate = true;
  bool _isValidPatient = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(_titleScreen),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: _isLoading
          ? const Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: availableHeight - 100,
                child: Column(
                  children: [
                    ChartForm(
                      formData: _formData,
                      form: _form,
                      isValidDate: _isValidDate,
                      isValidPatient: _isValidPatient,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cancelButton(
                              context, () => Navigator.of(context).pop()),
                          finishButton(context, _saveForm),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final Chart chart = ModalRoute.of(context).settings.arguments as Chart;
      if (chart != null) {
        setState(() {
          _titleScreen = 'Editar Prontuário';
        });
        _formData['id'] = chart.id;
        _formData['patientId'] = chart.patientId;
        _formData['date'] = chart.entryDate;
        _formData['note'] = chart.note;
      }
    }
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();
    setState(() {
      _isValidPatient = _formData['patientId'] != null;
      _isValidDate = _formData['date'] != null;
    });
    if (!isValid) return;
    _form.currentState.save();
    final chart = Chart(
      id: _formData['id'],
      patientId: _formData['patientId'],
      entryDate: _formData['date'],
      note: _formData['note'],
    );
    setState(() {
      _isLoading = true;
    });
    final charts = Provider.of<Charts>(context, listen: false);
    try {
      if (_formData['id'] == null) {
        charts.addChart(chart);
      } else {
        charts.updateChart(chart);
      }
      await showDialog<Null>(
        context: context,
        builder: (ctx) => aletDialogSuccess(
          context: ctx,
          message: 'O prontuário foi cadastrado com sucesso.',
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro pra salvar o prontuário!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
