import 'package:cloud_firestore/cloud_firestore.dart';

class TipoExameFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um tipo de Exame.
   */
  Future<void> create(descricao, nome, numEnfermeiros) async {
    final userData = {
      'descricao': descricao,
      'nome': nome,
      'numEnfermeiros': numEnfermeiros,
    };

    await FirebaseFirestore.instance
        .collection('tipoExame')
        .doc()
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do tipo de Exame.
   */
  Future<void> update(descricao, nome, numEnfermeiros, tipoExameId) async {
    final userData = {
      'descricao': descricao,
      'nome': nome,
      'numEnfermeiros': numEnfermeiros,
    };

    await db.collection('tipoExame').doc(tipoExameId).update(userData);
  }

  /*
   * Função responsável por deletar tipo de Exame.
   */
  Future<void> delete(tipoExameId) async {
    await db.collection('tipoExame').doc(tipoExameId).delete();
  }

  /*
   * Função responsável por pegar dados de tipos de Exames.
   */
  Future<Map<String, dynamic>> read(tipoExameId) async {
    var doc = await db.collection('tipoExame').doc(tipoExameId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos os tipos de Exames existentes e retornar um Stream de
   * documentos da coleção tipoExame.
   */
  Stream readAll() {
    var doc = db.collection('tipoExame').snapshots();
    return doc;
  }
}
