import 'package:clinica_medica/infra/prontuario_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProntuarioController {
  ProntuarioFB prontuarioFB = new ProntuarioFB();

  Future<void> cadastrarProntuario(infoProntuario) async {
    try {
      await prontuarioFB.create(infoProntuario.refPaciente,
          infoProntuario.refMedicamento, infoProntuario.nota);
    } catch (err) {
      print(err);
    }
  }

  Future<List<Map<String, dynamic>>> buscarProntuarios() async {
    List<Map<String, dynamic>> result = [];
    var data;
    QuerySnapshot prontuarios = await prontuarioFB.getProntuarios();

    for (int i = 0; i < prontuarios.size; i++) {
      data = prontuarios.docs[i].data();
      result.add({
        'id': prontuarios.docs[i].id,
        'dataAtualizacao': data['dataAtualizacao'],
        'dataCadastro': data['dataCadastro'],
        'nota': data['nota'],
        'refMedicamento': data['refMedicamento'].id,
        'refPaciente': data['refPaciente'].id,
      });
    }
    return result;
  }

  Future<void> editarProntuario(infoProntuario) async {
    await prontuarioFB.update(
        infoProntuario.refMedicamento, infoProntuario.id, infoProntuario.nota);
  }

  Future<void> excluirProntuario(prontuarioId) async {
    try {
      prontuarioFB.delete(prontuarioId);
    } catch (err) {
      print(err);
    }
  }
}
