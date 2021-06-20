import 'package:cloud_firestore/cloud_firestore.dart';

class MedicoFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um medico.
   */
  Future<void> create(crm, funcionarioId, salario) async {
    final userData = {
      'crm': crm,
      'refFuncionario': db.doc('funcionario/' + funcionarioId),
      'salario': salario,
    };

    await FirebaseFirestore.instance.collection('medico').doc().set(userData);
  }

  /*
   * Função responsável por modificar dados do medico.
   */
  Future<void> update(crm, funcionarioId, salario, medicoId) async {
    final userData = {
      'crm': crm,
      'refFuncionario': db.doc('funcionario/' + funcionarioId),
      'salario': salario,
    };

    await db.collection('medico').doc(medicoId).update(userData);
  }

  /*
   * Função responsável por deletar medico.
   */
  Future<void> delete(medicoId) async {
    await db.collection('medico').doc(medicoId).delete();
  }

  /*
   * Função responsável por pegar dados de medicos.
   */
  Future<Map<String, dynamic>> read(medicoId) async {
    var doc = await db.collection('medico').doc(medicoId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as medicos existentes e retornar um Stream de
   * documentos da coleção medico.
   */
  Stream readAll() {
    var doc = db.collection('medico').snapshots();
    return doc;
  }
}