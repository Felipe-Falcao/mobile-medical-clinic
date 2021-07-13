import 'package:cloud_firestore/cloud_firestore.dart';

class MedicamentoFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um medicamento.
   */
  Future<void> create(dataPrescricao, dose, nome, medicoId, pacienteId) async {
    final userData = {
      'dataPrescricao': dataPrescricao,
      'dose': dose,
      'nome': nome,
      'refMedico': db.doc('medico/' + medicoId),
      'refPaciente': db.doc('paciente/' + pacienteId),
    };

    await FirebaseFirestore.instance
        .collection('medicamento')
        .doc()
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do medicamento.
   */
  Future<void> update(dataPrescricao, dose, nome, medicamentoId) async {
    final userData = {
      'dataPrescricao': dataPrescricao,
      'dose': dose,
      'nome': nome,
      // 'refMedico': db.doc('medico/' + medicoId),
      // 'refPaciente': db.doc('paciente/' + pacienteId),
    };

    await db.collection('medicamento').doc(medicamentoId).update(userData);
  }

  /*
   * Função responsável por deletar medicamento.
   */
  Future<void> delete(medicamentoId) async {
    await db.collection('medicamento').doc(medicamentoId).delete();
  }

  /*
   * Função responsável por pegar dados de medicamentos.
   */
  Future<Map<String, dynamic>> read(medicamentoId) async {
    var doc = await db.collection('medicamento').doc(medicamentoId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as medicamentos existentes e retornar um Stream de
   * documentos da coleção medicamento.
   */
  Stream readAll() {
    var doc = db.collection('medicamento').snapshots();
    return doc;
  }

  /*
   * Função responsável por retornar todos os dados de medicamentos em formato
   * chave: valor.
   */
  Future<QuerySnapshot> getMedicamentos() async {
    var querySnapshot = await db.collection('medicamento').get();
    return querySnapshot;
  }
}
