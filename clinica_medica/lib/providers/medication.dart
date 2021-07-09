import 'package:clinica_medica/controllers/medicamento_controller.dart';
import 'package:clinica_medica/models/medicamento_data.dart';
import 'package:clinica_medica/models/receita.dart';
import 'package:flutter/material.dart';

class Medication with ChangeNotifier {
  MedicamentoController medicamentoController = MedicamentoController();
  List<Receita> _items = [];

  List<Receita> get items {
    return [..._items];
  }

  /** 
  List<InfoMedicamento> getItemsWith(String filter, List<Patient> patients) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items.where((chart) {
      Patient patient = patients.singleWhere((el) => el.id == chart.patientId);
      return patient.name.toLowerCase().contains(filter) ||
          patient.cpf.toLowerCase().contains(filter);
    }).toList();
  }*/

  Receita getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadMedications() async {
    List<Map<String, dynamic>> listaMedicamentos =
        await medicamentoController.buscarMedicamentos();
    _items.clear();
    for (var med in listaMedicamentos) {
      Receita receita = Receita(
        dataPrescricao: DateTime.fromMicrosecondsSinceEpoch(
          med['dataPrescricao'].microsecondsSinceEpoch,
        ),
        id: med['id'],
        nome: med['nome'],
        dose: med['dose'],
        refPaciente: med['refPaciente'],
        refMedico: med['refMedico'],
      );
      _items.add(receita);
    }
    notifyListeners();
  }

  Future<void> addMedication(Receita medicamento) async {
    if (medicamento == null) return null;

    InfoMedicamento med = InfoMedicamento();
    med.dataPrescricao = medicamento.dataPrescricao;
    med.dose = medicamento.dose;
    med.nome = medicamento.nome;
    med.refMedico = medicamento.refMedico;
    med.refPaciente = medicamento.refPaciente;

    await medicamentoController.cadastrarMedicamento(
        medicamento, medicamento.refPaciente, medicamento.refMedico);

    await loadMedications();
  }
/** 
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
    await chartCtrl.excluirProntuario(chart.id);
    _items.remove(chart);
    notifyListeners();
  }
  */
}
