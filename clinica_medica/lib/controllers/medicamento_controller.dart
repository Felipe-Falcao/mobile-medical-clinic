import 'package:clinica_medica/infra/medico_connect.dart';
import 'package:clinica_medica/infra/paciente_connect.dart';
import 'package:clinica_medica/infra/medicamento_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicamentoController {
  PacienteFB pacienteFB = new PacienteFB();
  MedicoFB medicoFB = new MedicoFB();
  MedicamentoFB medicamentoFB = new MedicamentoFB();

  Future<void> cadastrarMedicamento(
      infoMedicamento, pacienteId, medicoId) async {
    try {
      medicamentoFB.create(infoMedicamento.dataPrescricao, infoMedicamento.dose,
          infoMedicamento.nome, medicoId, pacienteId);
    } catch (err) {
      print(err);
    }
  }

  Future<List<dynamic>> buscarMedicamentos() async {
    var result = [];
    var data;
    QuerySnapshot medicamentos = await medicamentoFB.getMedicamentos();

    for (int i = 0; i < medicamentos.size; i++) {
      data = medicamentos.docs[i].data();
      result.add({
        'id': medicamentos.docs[i].id,
        'dataPrescricao': data['dataPrescricao'],
        'dose': data['dose'],
        'nome': data['nome'],
        'refMedico': data['refMedico'],
        'refPaciente': data['refPaciente'],
      });
    }
    return result;
  }

  void editarMedicamento(infoMedicamento) {
    medicamentoFB.update(infoMedicamento.dataPrescricao, infoMedicamento.dose,
        infoMedicamento.nome, infoMedicamento.id);
  }

  // Future<void> excluirMedicamento(medicamentoId) async {
  //   try {
  //     medicamentoFB.delete(medicamentoId);
  //   } catch (err) {
  //     print(err);
  //   }
  // }
}
