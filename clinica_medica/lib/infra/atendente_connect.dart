import 'package:cloud_firestore/cloud_firestore.dart';

class AtendenteFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um atendente.
   */
  Future<void> create(salario, funcionarioId, turno) async {
    final userData = {
      'salario': salario,
      'refFuncionario': db.doc('funcionario/' + funcionarioId),
      'turno': turno,
    };
    print(userData);
    await FirebaseFirestore.instance
        .collection('atendente')
        .doc(funcionarioId)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do atendente.
   */
  Future<void> update(salario, funcionarioId, turno, atendenteId) async {
    final userData = {
      'salario': salario,
      'refFuncionario': db.doc('funcionario/' + funcionarioId),
      'turno': turno,
    };

    await db.collection('atendente').doc(atendenteId).update(userData);
  }

  /*
   * Função responsável por deletar atendente.
   */
  Future<void> delete(atendenteId) async {
    await db.collection('atendente').doc(atendenteId).delete();
  }

  /*
   * Função responsável por pegar dados de atendentes.
   */
  Future<Map<String, dynamic>> read(atendenteId) async {
    var doc = await db.collection('atendente').doc(atendenteId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos os atendentes existentes e retornar um Stream de
   * documentos da coleção atendente.
   */
  Stream readAll() {
    var doc = db.collection('atendente').snapshots();
    return doc;
  }

  DocumentReference getDocRef(funcionarioId) {
    var doc = db.collection('atendente').doc(funcionarioId);
    return doc;
  }
}
