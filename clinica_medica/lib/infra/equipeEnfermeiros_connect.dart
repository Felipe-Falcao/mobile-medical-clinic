import 'package:cloud_firestore/cloud_firestore.dart';

class EquipeEnfermeirosFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar uma equipe de enfermeiros.
   */
  Future<void> create(enfermeiroId, exameId) async {
    final userData = {
      'refEnfermeiro': db.doc('enfermeiro/' + enfermeiroId),
      'refExame': db.doc('exame/' + exameId),
    };

    await FirebaseFirestore.instance
        .collection('equipeEnfermeiros')
        .doc()
        .set(userData);
  }

  /*
   * Função responsável por modificar dados da equipe de enfermeiros.
   */
  Future<void> update(enfermeiroId, exameId, equipeEnfermeirosId) async {
    final userData = {
      'refEnfermeiro': db.doc('enfermeiro/' + enfermeiroId),
      'refExame': db.doc('exame/' + exameId),
    };

    await db
        .collection('equipeEnfermeiros')
        .doc(equipeEnfermeirosId)
        .update(userData);
  }

  /*
   * Função responsável por deletar equipe de enfermeiros.
   */
  Future<void> delete(equipeEnfermeirosId) async {
    await db.collection('equipeEnfermeiros').doc(equipeEnfermeirosId).delete();
  }

  /*
   * Função responsável por pegar dados de equipe de enfermeiross.
   */
  Future<Map<String, dynamic>> read(equipeEnfermeirosId) async {
    var doc =
        await db.collection('equipeEnfermeiros').doc(equipeEnfermeirosId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as equipe de enfermeiross existentes e retornar um Stream de
   * documentos da coleção equipe de enfermeiros.
   */
  Stream readAll() {
    var doc = db.collection('equipeEnfermeiros').snapshots();
    return doc;
  }
}
