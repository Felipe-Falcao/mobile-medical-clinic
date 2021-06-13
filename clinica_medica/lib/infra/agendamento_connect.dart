import 'package:cloud_firestore/cloud_firestore.dart';

class AgendamentoFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um agendamento.
   */
  Future<void> create(data, atendenteId, tipo) async {
    final userData = {
      'data': data,
      'refAtendente': db.doc('atendente/' + atendenteId),
      'tipo': tipo,
    };

    await FirebaseFirestore.instance
        .collection('agendamento')
        .doc()
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do agendamento.
   */
  Future<void> update(data, atendenteId, tipo, agendamentoId) async {
    final userData = {
      'data': data,
      'refAtendente': db.doc('atendente/' + atendenteId),
      'tipo': tipo,
    };

    await db.collection('agendamento').doc(agendamentoId).update(userData);
  }

  /*
   * Função responsável por deletar agendamento.
   */
  Future<void> delete(agendamentoId) async {
    await db.collection('agendamento').doc(agendamentoId).delete();
  }

  /*
   * Função responsável por pegar dados de agendamentos.
   */
  Future<Map<String, dynamic>> read(agendamentoId) async {
    var doc = await db.collection('agendamento').doc(agendamentoId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos os agendamentos existentes e retornar um Stream de
   * documentos da coleção agendamento.
   */
  Stream readAll() {
    var doc = db.collection('agendamento').snapshots();
    return doc;
  }
}
