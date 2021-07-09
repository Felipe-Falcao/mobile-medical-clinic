import 'package:cloud_firestore/cloud_firestore.dart';

class EspecialidadeFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar uma especialidade.
   */
  Future<void> create(nomeEspecialidade) async {
    final userData = {
      'nomeEspecialidade': nomeEspecialidade,
    };

    await FirebaseFirestore.instance
        .collection('especialidade')
        .doc(nomeEspecialidade)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados da especialidade.
   */
  Future<void> update(nomeEspecialidade, especialidadeId) async {
    final userData = {
      'nomeEspecialidade': nomeEspecialidade,
    };

    await db.collection('especialidade').doc(especialidadeId).update(userData);
  }

  /*
   * Função responsável por deletar especialidade.
   */
  Future<void> delete(especialidadeId) async {
    await db.collection('especialidade').doc(especialidadeId).delete();
  }

  /*
   * Função responsável por pegar dados de especialidades.
   */
  Future<Map<String, dynamic>> read(especialidadeId) async {
    var doc = await db.collection('especialidade').doc(especialidadeId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as especialidades existentes e retornar um Stream de
   * documentos da coleção especialidade.
   */
  Stream readAll() {
    var doc = db.collection('especialidade').snapshots();
    return doc;
  }

  DocumentReference getDocRef(nomeEspecialidade) {
    var doc = db.collection('especialidade').doc(nomeEspecialidade);
    return doc;
  }

  Future<QuerySnapshot> getEspecialidades() async {
    var querySnapshot = await db.collection('especialidade').get();
    return querySnapshot;
  }
}
