import 'package:cloud_firestore/cloud_firestore.dart';

class EnfermeiroFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um enfermeiro.
   */
  Future<void> create(cre, funcionarioId, salario) async {
    final userData = {
      'CRE': cre,
      'refFuncionario': db.doc('funcionario/' + funcionarioId),
      'salario': salario,
    };

    await FirebaseFirestore.instance
        .collection('enfermeiro')
        .doc()
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do enfermeiro.
   */
  Future<void> update(cre, funcionarioId, salario, enfermeiroId) async {
    final userData = {
      'CRE': cre,
      'refFuncionario': db.doc('funcionario/' + funcionarioId),
      'salario': salario,
    };

    await db.collection('enfermeiro').doc(enfermeiroId).update(userData);
  }

  /*
   * Função responsável por deletar enfermeiro.
   */
  Future<void> delete(enfermeiroId) async {
    await db.collection('enfermeiro').doc(enfermeiroId).delete();
  }

  /*
   * Função responsável por pegar dados de enfermeiros.
   */
  Future<Map<String, dynamic>> read(enfermeiroId) async {
    var doc = await db.collection('enfermeiro').doc(enfermeiroId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos os enfermeiros existentes e retornar um Stream de
   * documentos da coleção enfermeiro.
   */
  Stream readAll() {
    var doc = db.collection('enfermeiro').snapshots();
    return doc;
  }
}
