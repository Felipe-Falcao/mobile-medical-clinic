import 'package:clinica_medica/controllers/medicamento_controller.dart';
import 'package:clinica_medica/models/medicamento_data.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/receita.dart';
import 'package:flutter/material.dart';

class Medication with ChangeNotifier {
  MedicamentoController medicamentoController = MedicamentoController();
  List<Receita> _items = [];

  List<Receita> get items {
    return [..._items];
  }

  List<Receita> getItemsWith(String filter, List<Patient> patients) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items.where((rec) {
      Patient patient = patients.singleWhere((el) => el.id == rec.refPaciente);
      return patient.name.toLowerCase().contains(filter) ||
          patient.cpf.toLowerCase().contains(filter);
    }).toList();
  }

  Receita getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadMedications() async {
    List<dynamic> listaMedicamentos =
        await medicamentoController.buscarMedicamentos();
    _items.clear();
    for (var med in listaMedicamentos) {
      // print(med['dataPrescricao']);
      Receita receita = Receita(
        dataPrescricao: DateTime.fromMicrosecondsSinceEpoch(
            med['dataPrescricao'].microsecondsSinceEpoch),
        id: med['id'],
        nome: med['nome'],
        dose: med['dose'],
        refPaciente: med['refPaciente'].id,
        refMedico: med['refMedico'].id,
      );
      _items.add(receita);
    }
    notifyListeners();
  }

  Future<void> addMedication(Receita medicamento) async {
    if (medicamento == null) return null;

    InfoMedicamento med = InfoMedicamento();
    med.dataPrescricao = DateTime.now();
    med.dose = medicamento.dose;
    med.nome = medicamento.nome;
    med.refMedico = medicamento.refMedico;
    med.refPaciente = medicamento.refPaciente;

    await medicamentoController.cadastrarMedicamento(
        medicamento, medicamento.refPaciente, medicamento.refMedico);

    await loadMedications();
  }

  Future<void> updateMedication(Receita medicamento) async {
    if (medicamento == null || medicamento.id == null) return;

    InfoMedicamento med = InfoMedicamento();
    med.id = medicamento.id;
    med.dataPrescricao = DateTime.now();
    med.dose = medicamento.dose;
    med.nome = medicamento.nome;
    med.refMedico = medicamento.refMedico;
    med.refPaciente = medicamento.refPaciente;

    await medicamentoController.editarMedicamento(med);

    await loadMedications();
  }

  Future<void> removeMedication(Receita rec) async {
    if (rec == null) return;

    await medicamentoController.excluirMedicamento(rec.id);
    _items.remove(rec);

    notifyListeners();
  }
}
