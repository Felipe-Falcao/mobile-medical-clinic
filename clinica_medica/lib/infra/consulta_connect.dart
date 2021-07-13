import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultaFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar uma consulta.
   */
  Future<void> create(
      atestado, agendamentoId, medicoId, pacienteId, resultado) async {
    final userData = {
      'atestado': atestado,
      'refAgendamento': db.doc('agendamento/' + agendamentoId),
      'refMedico': db.doc('medico/' + medicoId),
      'refPaciente': db.doc('paciente/' + pacienteId),
      'resultado': resultado,
    };

    await FirebaseFirestore.instance.collection('consulta').doc().set(userData);
  }

  /*
   * Função responsável por modificar dados da consulta.
   */
  Future<void> update(atestado, resultado, consultaId) async {
    final userData = {
      'atestado': atestado,
      // 'refAgendamento': db.doc('agendamento/' + agendamentoId),
      // 'refMedico': db.doc('medico/' + medicoId),
      // 'refPaciente': db.doc('paciente/' + pacienteId),
      'resultado': resultado,
    };

    await db.collection('consulta').doc(consultaId).update(userData);
  }

  /*
   * Função responsável por deletar consulta.
   */
  Future<void> delete(consultaId) async {
    await db.collection('consulta').doc(consultaId).delete();
  }

  /*
   * Função responsável por pegar dados de consultas.
   */
  Future<Map<String, dynamic>> read(consultaId) async {
    var doc = await db.collection('consulta').doc(consultaId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as consultas existentes e retornar um Stream de
   * documentos da coleção consulta.
   */
  Stream readAll() {
    var doc = db.collection('consulta').snapshots();
    return doc;
  }

  /*
   * Função responsável por ler todos as consultas existentes e retornar uma
   * QuerySnapshot com os dados obtidos.
   */
  Future<QuerySnapshot> getConsultas() async {
    var querySnapshot = await db.collection('consulta').get();
    return querySnapshot;
  }
}
