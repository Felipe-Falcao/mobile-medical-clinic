import 'package:clinica_medica/controllers/prontuario_controller.dart';
import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/prontuario_data.dart';
import 'package:flutter/material.dart';

class Charts with ChangeNotifier {
  ProntuarioController chartCtrl = ProntuarioController();
  List<Chart> _items = [];

  List<Chart> get items {
    return [..._items];
  }

  List<Chart> getItemsWith(String filter, List<Patient> patients) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items.where((chart) {
      Patient patient = patients.singleWhere((el) => el.id == chart.patientId);
      return patient.name.toLowerCase().contains(filter) ||
          patient.cpf.toLowerCase().contains(filter);
    }).toList();
  }

  Chart getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadCharts() async {
    List<Map<String, dynamic>> chartsList = await chartCtrl.buscarProntuarios();
    _items.clear();
    for (var chartMap in chartsList) {
      Chart chart = Chart(
        id: chartMap['id'],
        entryDate: DateTime.fromMicrosecondsSinceEpoch(
            chartMap['dataCadastro'].microsecondsSinceEpoch),
        updateDate: DateTime.fromMicrosecondsSinceEpoch(
            chartMap['dataAtualizacao'].microsecondsSinceEpoch),
        patientId: chartMap['refPaciente'],
        medicineId: chartMap['refMedicamento'],
        note: chartMap['nota'],
      );
      _items.add(chart);
    }
    notifyListeners();
  }

  Future<void> addChart(Chart chart) async {
    if (chart == null) return;
    InfoProntuario infoProntuario = InfoProntuario();
    infoProntuario.refPaciente = chart.patientId;
    //TODO ainda n tem referencia para medicamento
    infoProntuario.refMedicamento = chart.medicineId;
    infoProntuario.nota = chart.note;
    // await chartCtrl.cadastrarProntuario(infoProntuario);
    // await loadCharts();
  }

  Future<void> updateChart(Chart chart) async {
    if (chart == null || chart.id == null) return;
    InfoProntuario infoProntuario = InfoProntuario();
    infoProntuario.id = chart.id;
    infoProntuario.refMedicamento = chart.medicineId;
    infoProntuario.nota = chart.note;
    await chartCtrl.editarProntuario(infoProntuario);
    await loadCharts();
  }

  Future<void> removeChart(Chart chart) async {
    if (chart == null) return;
    /*  
     * TODO falta tratar a exclusao de prontuarios 
     * que contenha referencia para um paciente excluido
     */
    await chartCtrl.excluirProntuario(chart.id);
    _items.remove(chart);
    notifyListeners();
  }
}
