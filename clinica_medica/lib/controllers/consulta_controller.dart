import 'package:clinica_medica/infra/agendamento_connect.dart';
import 'package:clinica_medica/infra/consulta_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConsultaController {
  AgendamentoFB agendamentoFB = new AgendamentoFB();
  ConsultaFB consultaFB = new ConsultaFB();

  Future<void> agendarConsulta(infoConsulta) async {
    try {
      // Cadastrar Agendamento
      agendamentoFB.create(
          infoConsulta.data, infoConsulta.refAtendente, infoConsulta.tipo);
      // Obter referência de agendamento
      DateFormat formatter = DateFormat('yyyy.MM.dd;hh:mm;aaa');
      DocumentReference agendamentoId = agendamentoFB.getDocRef(
          infoConsulta.refAtendente, formatter.format(infoConsulta.data));
      // Cadastrar Consulta
      consultaFB.create(
        '',
        agendamentoId.id,
        infoConsulta.refMedico,
        infoConsulta.refPaciente,
        '',
      );
    } catch (err) {
      print(err);
    }
  }

  void editarConsulta(infoConsulta) {
    consultaFB.update(
        infoConsulta.atestado, infoConsulta.resultado, infoConsulta.id);
    agendamentoFB.update(infoConsulta.data, infoConsulta.refAgendamento);
  }

  Future<List<dynamic>> buscarConsultas() async {
    var result = [];
    var data;
    QuerySnapshot consultas = await consultaFB.getConsultas();

    for (int i = 0; i < consultas.size; i++) {
      data = consultas.docs[i].data();
      result.add({
        'id': consultas.docs[i].id,
        'atestado': data['atestado'],
        'resultado': data['resultado'],
        'refAgendamento': data['refAgendamento'],
        'refMedico': data['refMedico'],
        'refPaciente': data['refPaciente'],
      });
    }
    return result;
  }

  Future<Map<String, dynamic>> buscarAgendamento(agendamentoId) async {
    try {
      return await agendamentoFB.read(agendamentoId);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<Map<String, dynamic>> buscarConsulta(consultaId) async {
    try {
      return await consultaFB.read(consultaId);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<void> excluirConsulta(consultaId, agendamentoId) async {
    try {
      // Excluir paciente
      await consultaFB.delete(consultaId);
      // Excluir endereco
      await agendamentoFB.delete(agendamentoId);
    } catch (err) {
      print(err);
    }
  }
}
