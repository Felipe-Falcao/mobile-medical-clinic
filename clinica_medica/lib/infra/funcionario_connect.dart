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
      'refEndereco': db.doc('endereco/' + enderecoId),
      'refEspecialidade': db.doc('especialidade/' + especialidadeId),
      'telefone': '79 99999999'
    };

    await FirebaseFirestore.instance
        .collection('funcionario')
        .doc(userCredential.user.uid)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do funcionário.
   * Exemplo de chamada:
   * await func.update(authData, 'BYo4qMI6ZTQkVK4fKhcwCLQuJyP2', 'null', 'null');
   */
  Future<void> update(
      authData, funcionarioId, enderecoId, especialidadeId) async {
    final userData = {
      'nome': authData.name,
      'carteiraTrabalho': '1234567',
      'dataContratacao': DateTime.now(),
      'email': authData.email,
      'refEndereco': db.doc('endereco/' + enderecoId),
      'refEspecialidade': db.doc('especialidade/' + especialidadeId),
      'telefone': '79 99999999'
    };

    await db.collection("funcionario").doc(funcionarioId).update(userData);
  }

  /*
   * Função responsável por deletar funcionário.
   * Exemplo de chamada: await func.delete("muhwBIA3yyO8lGLB4fuepl2YpPD2");
   */
  Future<void> delete(funcionarioId) async {
    await db.collection('funcionario').doc(funcionarioId).delete();
  }

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

  /*
   * Função responsável por ler todos os funcionarios existentes e retornar um Stream de
   * documentos da coleção funcionário.
   */
  Stream readAll() {
    var doc = db.collection('funcionario').snapshots();
    return doc;
  }
}
