import 'package:cloud_firestore/cloud_firestore.dart';

class FuncionarioFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um funcionário.
   */
  Future<void> create(
      authData, userCredential, enderecoId, especialidadeId) async {
    final userData = {
      'nome': authData.name,
      'carteiraTrabalho': '123456',
      'dataContratacao': DateTime.now(),
      'email': authData.email,
      'refEndereco': 'endereco/' + enderecoId,
      'refEspecialidade': 'especialidade/' + especialidadeId,
      'telefone': '79 99999999'
    };

    await FirebaseFirestore.instance
        .collection('funcionario')
        .doc(userCredential.user.uid)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do funcionário.
   */
  Future<void> update() async {}

  /*
   * Função responsável por deletar funcionário.
   */
  Future<void> delete() async {}

  /*
   * Função responsável por pegar dados de funcionários.
   * Exemplo de leitura:
   * var a = await func.read('23IfKpVrq7RLOzmunlDOCV9YQdu1');
   * print(a['nome']);
   */
  Future<Map<String, dynamic>> read(funcionarioId) async {
    var doc = await db.collection('funcionario').doc(funcionarioId).get();
    return doc.data();
  }
}
