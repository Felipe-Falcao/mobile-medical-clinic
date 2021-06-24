import 'package:cloud_firestore/cloud_firestore.dart';

class PacienteFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um paciente.
   */
  Future<void> create(cpf, dataNascimento, nome, enderecoId, telefone) async {
    final userData = {
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'nome': nome,
      'refEndereco': db.doc('endereco/' + enderecoId),
      'telefone': telefone,
    };

    await FirebaseFirestore.instance.collection('paciente').doc().set(userData);
  }

  /*
   * Função responsável por modificar dados do paciente.
   */
  Future<void> update(cpf, dataNascimento, nome, telefone, pacienteId) async {
    final userData = {
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'nome': nome,
      'telefone': telefone,
    };

    await db.collection('paciente').doc(pacienteId).update(userData);
  }

  /*
   * Função responsável por deletar paciente.
   */
  Future<void> delete(pacienteId) async {
    await db.collection('paciente').doc(pacienteId).delete();
  }

  /*
   * Função responsável por pegar dados de pacientes.
   */
  Future<Map<String, dynamic>> read(pacienteId) async {
    var doc = await db.collection('paciente').doc(pacienteId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos as pacientes existentes e retornar um Stream de
   * documentos da coleção paciente.
   */
  Stream readAll() {
    var doc = db.collection('paciente').snapshots();
    return doc;
  }

  Future<QuerySnapshot> getPacientes() async {
    var querySnapshot = await db.collection('paciente').get();
    return querySnapshot;
  }

  Future<String> getPacienteId(data) async {
    var querySnapshot =
        await db.collection('paciente').where('cpf', isEqualTo: data).get();
    return querySnapshot.docs[0].id;
  }
}
