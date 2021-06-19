import 'package:clinica_medica/infra/funcionario_connect.dart';
import 'package:clinica_medica/infra/atendente_connect.dart';
import 'package:clinica_medica/infra/medico_connect.dart';

class FuncionarioController {
  FuncionarioFB funcionarioFB = new FuncionarioFB();
  AtendenteFB atendenteFB = new AtendenteFB();
  MedicoFB medicoFB = new MedicoFB();

  Future<void> createFuncAtendente(authData, userCredential, enderecoId,
      especialidadeId, salario, turno) async {
    try {
      await funcionarioFB.create(
          authData, userCredential, enderecoId, especialidadeId);
      await atendenteFB.create(salario, userCredential.user.uid, turno);
    } catch (err) {
      print(err);
    }
  }

  Future<void> createfuncMedico(authData, userCredential, enderecoId,
      especialidadeId, salario, crm) async {
    try {
      await funcionarioFB.create(
          authData, userCredential, enderecoId, especialidadeId);
      await medicoFB.create(crm, userCredential, salario);
    } catch (err) {
      print(err);
    }
  }

  Future<void> update(
      authData, funcionarioId, enderecoId, especialidadeId) async {
    await funcionarioFB.update(
        authData, funcionarioId, enderecoId, especialidadeId);
  }

  Future<void> delete(funcionarioId) async {
    await funcionarioFB.delete(funcionarioId);
  }

  Future<Map<String, dynamic>> read(funcionarioId) async {
    await funcionarioFB.read(funcionarioId);
  }

  Stream readAll() {
    funcionarioFB.readAll();
  }
}

// TESTES
// await funcionarioController.createFuncAtendente(
// authData, userCredential, 'null', 'null', 10000, 'Manhã');
