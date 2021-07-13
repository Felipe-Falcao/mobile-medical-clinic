import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AgendamentoFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um agendamento.
   */
  Future<void> create(data, horario) async {
    final userData = {
      'data': data,
      // 'refAtendente': db.doc('atendente/' + atendenteId),
      'horario': horario,
    };

    DateFormat formatter = DateFormat('yyyy.MM.dd;hh:mm;aaa');
    String docId = horario + formatter.format(data);

    await FirebaseFirestore.instance
        .collection('agendamento')
        .doc(docId)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do agendamento.
   */
  Future<void> update(data, horario, agendamentoId) async {
    final userData = {
      'data': data,
      // 'refAtendente': db.doc('atendente/' + atendenteId),
      'horario': horario,
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

  /*
   * Função responsável por receber uma data e hora e retornar a referencia do
   * documento de agendamento.
   */
  DocumentReference getDocRef(horario, data) {
    var doc = db.collection('agendamento').doc(horario + data);
    return doc;
  }
}
