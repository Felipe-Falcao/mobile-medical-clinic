import 'package:cloud_firestore/cloud_firestore.dart';

class EnderecoFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um endereco.
   */
  Future<void> create(cep, cidade, estado, logradouro, numero) async {
    final userData = {
      'CEP': cep,
      'cidade': cidade,
      'estado': estado,
      'logradouro': logradouro,
      'numero': numero,
    };

    String docId = cidade + cep + numero;

    await FirebaseFirestore.instance
        .collection('endereco')
        .doc(docId)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do endereco.
   */
  Future<void> update(
      cep, cidade, estado, logradouro, numero, enderecoId) async {
    final userData = {
      'CEP': cep,
      'cidade': cidade,
      'estado': estado,
      'logradouro': logradouro,
      'numero': numero,
    };

    await db.collection('endereco').doc(enderecoId).update(userData);
  }

  /*
   * Função responsável por deletar endereco.
   */
  Future<void> delete(enderecoId) async {
    await db.collection('endereco').doc(enderecoId).delete();
  }

  /*
   * Função responsável por pegar dados de enderecos.
   */
  Future<Map<String, dynamic>> read(enderecoId) async {
    var doc = await db.collection('endereco').doc(enderecoId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as enderecos existentes e retornar um Stream de
   * documentos da coleção endereco.
   */
  Stream readAll() {
    var doc = db.collection('endereco').snapshots();
    return doc;
  }

  /*
   * Função responsável por receber uma cidade, cep e numero e retornar a referência do
   * documento de endereco.
   */
  DocumentReference getDocRef(cidade, cep, numero) {
    var doc = db.collection('endereco').doc(cidade + cep + numero);
    return doc;
  }
}
