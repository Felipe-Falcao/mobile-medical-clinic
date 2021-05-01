import 'package:cloud_firestore/cloud_firestore.dart';

class FuncionarioFB {
  Future<void> create(authData, userCredential) async {
    final userData = {
      'nome': authData.name,
      'carteiraTrabalho': '123456',
      'dataContratacao': DateTime.now(),
      'email': authData.email,
      'refEndereco': 'endereco/null',
      'refEspecialidade': 'endereco/null',
      'telefone': '79 99999999'
    };

    await FirebaseFirestore.instance
        .collection('funcionario')
        .doc(userCredential.user.uid)
        .set(userData);
  }
}
