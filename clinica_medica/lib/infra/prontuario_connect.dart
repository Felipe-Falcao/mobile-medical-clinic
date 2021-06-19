import 'package:cloud_firestore/cloud_firestore.dart';

class ProntuarioFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um prontuario.
   */
  Future<void> create(pacienteId) async {
    final userData = {
      'dataCadastro': DateTime.now(),
      'dataAtualizacao': DateTime.now(),
      'refPaciente': db.doc('paciente/' + pacienteId),
    };

    await FirebaseFirestore.instance
        .collection('prontuario')
        .doc()
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do prontuario.
   */
  Future<void> update(pacienteId, prontuarioId) async {
    final userData = {
      'dataAtualizacao': DateTime.now(),
      'refPaciente': db.doc('paciente/' + pacienteId),
    };

    await db.collection('prontuario').doc(prontuarioId).update(userData);
  }

  /*
   * Função responsável por deletar prontuario.
   */
  Future<void> delete(prontuarioId) async {
    await db.collection('prontuario').doc(prontuarioId).delete();
  }

  /*
   * Função responsável por pegar dados de prontuarios.
   */
  Future<Map<String, dynamic>> read(prontuarioId) async {
    var doc = await db.collection('prontuario').doc(prontuarioId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as prontuarios existentes e retornar um Stream de
   * documentos da coleção prontuario.
   */
  Stream readAll() {
    var doc = db.collection('prontuario').snapshots();
    return doc;
  }
}
