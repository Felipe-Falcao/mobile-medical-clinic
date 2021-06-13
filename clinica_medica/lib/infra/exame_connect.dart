import 'package:cloud_firestore/cloud_firestore.dart';

class ExameFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um exame.
   */
  Future<void> create(dataResultado, agendamentoId, enfermeiroId, medicoId,
      pacienteId, tipoExameId, resultado) async {
    final userData = {
      'dataResultado': dataResultado,
      'refAgendamento': db.doc('agendamento/' + agendamentoId),
      'refEnfermeiro': db.doc('enfermeiro/' + enfermeiroId),
      'refMedico': db.doc('medico/' + medicoId),
      'refPaciente': db.doc('paciente/' + pacienteId),
      'refTipoExame': db.doc('tipoExame/' + tipoExameId),
      'resultado': resultado,
    };

    await FirebaseFirestore.instance.collection('exame').doc().set(userData);
  }

  /*
   * Função responsável por modificar dados do exame.
   */
  Future<void> update(dataResultado, agendamentoId, enfermeiroId, medicoId,
      pacienteId, tipoExameId, resultado, exameId) async {
    final userData = {
      'dataResultado': dataResultado,
      'refAgendamento': db.doc('agendamento/' + agendamentoId),
      'refEnfermeiro': db.doc('enfermeiro/' + enfermeiroId),
      'refMedico': db.doc('medico/' + medicoId),
      'refPaciente': db.doc('paciente/' + pacienteId),
      'refTipoExame': db.doc('tipoExame/' + tipoExameId),
      'resultado': resultado,
    };

    await db.collection('exame').doc(exameId).update(userData);
  }

  /*
   * Função responsável por deletar exame.
   */
  Future<void> delete(exameId) async {
    await db.collection('exame').doc(exameId).delete();
  }

  /*
   * Função responsável por pegar dados de exames.
   */
  Future<Map<String, dynamic>> read(exameId) async {
    var doc = await db.collection('exame').doc(exameId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as exames existentes e retornar um Stream de
   * documentos da coleção exame.
   */
  Stream readAll() {
    var doc = db.collection('exame').snapshots();
    return doc;
  }
}
