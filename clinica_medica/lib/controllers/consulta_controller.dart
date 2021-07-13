import 'package:clinica_medica/infra/agendamento_connect.dart';
import 'package:clinica_medica/infra/consulta_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/*
 * Classe responsável por realizar o controle das requisições de Agendamento e Consulta da camada de Infra.
 */
class ConsultaController {
  AgendamentoFB agendamentoFB = new AgendamentoFB();
  ConsultaFB consultaFB = new ConsultaFB();

  /*
   * Função responsável por receber dados de consulta e chamar as funções 
   * de criação de agendamento e consulta.
   */
  Future<void> agendarConsulta(infoConsulta) async {
    try {
      // Cadastrar Agendamento
      await agendamentoFB.create(infoConsulta.data, infoConsulta.horario);
      // Obter referência de agendamento
      DateFormat formatter = DateFormat('yyyy.MM.dd;hh:mm;aaa');
      DocumentReference agendamentoId = agendamentoFB.getDocRef(
          infoConsulta.horario, formatter.format(infoConsulta.data));
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

  /*
   * Função responsável por receber dados de consulta e chamar as funções 
   * de atualização de agendamento e consulta.
   */
  Future<void> editarConsulta(infoConsulta) async {
    try {
      await consultaFB.update(
          infoConsulta.atestado, infoConsulta.resultado, infoConsulta.id);
      await agendamentoFB.update(
          infoConsulta.data, infoConsulta.horario, infoConsulta.refAgendamento);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por chamar as funções de busca de consultas, 
   * montar um Map de Strings. Retorna o Map obtido com cada consulta existente.
   */
  Future<List<Map<String, dynamic>>> buscarConsultas() async {
    List<Map<String, dynamic>> result = [];
    var data;
    QuerySnapshot consultas = await consultaFB.getConsultas();

    for (int i = 0; i < consultas.size; i++) {
      data = consultas.docs[i].data();
      result.add({
        'id': consultas.docs[i].id,
        'atestado': data['atestado'],
        'resultado': data['resultado'],
        'refAgendamento': data['refAgendamento'].id,
        'refMedico': data['refMedico'].id,
        'refPaciente': data['refPaciente'].id,
      });
    }
    return result;
  }

  /*
   * Função responsável por receber um id de agendamento e  chamar a função 
   * de busca de agendamento. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarAgendamento(agendamentoId) async {
    try {
      return await agendamentoFB.read(agendamentoId);
    } catch (err) {
      print(err);
      return null;
    }
  }

  /*
   * Função responsável por receber um id de consulta e  chamar a função 
   * de busca de consulta. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarConsulta(consultaId) async {
    try {
      return await consultaFB.read(consultaId);
    } catch (err) {
      print(err);
      return null;
    }
  }

  /*
   * Função responsável por receber id's de consulta e agendamento e  chamar as 
   * funções de delete de consulta e agendamento. 
   */
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
