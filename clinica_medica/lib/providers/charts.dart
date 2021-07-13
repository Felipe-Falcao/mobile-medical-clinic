import 'package:clinica_medica/controllers/prontuario_controller.dart';
import 'package:clinica_medica/models/chart.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/prontuario_data.dart';
import 'package:flutter/material.dart';

/*
 * Classe responsavel por fazer a comunicacao da camada View com a 
 * camada de Controle da aplicaçao em relaçao as funcionalidades de prontuario.
 */
class Charts with ChangeNotifier {
  final ProntuarioController _chartCtrl = ProntuarioController();
  List<Chart> _items = [];

  /*
  * Retorna uma lista de todos os prontuarios cadastrados
  */
  List<Chart> get items => [..._items];
  int get itemsCount => _items.length;

  /*
  * Retorna um prontuario dado o ID
  */
  Chart getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  /*
  * Retorna uma lista de prontuarios cujos items contenha um filtro especificado.
  * Esse filtro pode ser parte do nome ou cpf do paciente.
  */
  List<Chart> getItemsWith(String filter, List<Patient> patients) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items.where((chart) {
      Patient patient = patients.singleWhere((el) => el.id == chart.patientId);
      return patient.name.toLowerCase().contains(filter) ||
          patient.cpf.toLowerCase().contains(filter);
    }).toList();
  }

  /*
  * Carrega os dados atualizados dos prontuarios cadastrados
  */
  Future<void> loadCharts() async {
    List<Map<String, dynamic>> chartsList =
        await _chartCtrl.buscarProntuarios();
    _items.clear();
    for (var chartMap in chartsList) {
      Chart chart = Chart(
        id: chartMap['id'],
        entryDate: DateTime.fromMicrosecondsSinceEpoch(
            chartMap['dataCadastro'].microsecondsSinceEpoch),
        updateDate: DateTime.fromMicrosecondsSinceEpoch(
            chartMap['dataAtualizacao'].microsecondsSinceEpoch),
        patientId: chartMap['refPaciente'],
        // medicineId: chartMap['refMedicamento'],
        note: chartMap['nota'],
      );
      _items.add(chart);
    }
    notifyListeners();
  }

  /*
  * Cadastra um novo prontuario
  */
  Future<void> addChart(Chart chart) async {
    if (chart == null) return;
    InfoProntuario infoProntuario = InfoProntuario();
    infoProntuario.refPaciente = chart.patientId;
    infoProntuario.nota = chart.note;
    //TODO - ainda n tem referencia para medicamento
    // infoProntuario.refMedicamento = chart.medicineId;
    await _chartCtrl.cadastrarProntuario(infoProntuario);
    await loadCharts();
  }

  /*
  * Atualiza um prontuario
  */
  Future<void> updateChart(Chart chart) async {
    if (chart == null || chart.id == null) return;
    InfoProntuario infoProntuario = InfoProntuario();
    infoProntuario.id = chart.id;
    infoProntuario.nota = chart.note;
    // infoProntuario.refMedicamento = chart.medicineId;
    await _chartCtrl.editarProntuario(infoProntuario);
    await loadCharts();
  }

  /*
  * Remove um prontuario
  */
  Future<void> removeChart(Chart chart) async {
    if (chart == null) return;
    await _chartCtrl.excluirProntuario(chart.id);
    _items.remove(chart);
    notifyListeners();
  }

  /*
  * Remove todos os prontuario que tenham referencia para um paciente ou medicamento,
  * dado o ID do medicamento ou paciente.
  */
  Future<void> removeChartsWith(String id) async {
    for (Chart chart in _items) {
      if (chart.patientId == id || chart.medicineId == id) {
        await _chartCtrl.excluirProntuario(chart.id);
      }
    }
    await loadCharts();
  }
}
