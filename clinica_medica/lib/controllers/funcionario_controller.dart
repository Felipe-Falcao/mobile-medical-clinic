import 'package:clinica_medica/infra/funcionario_connect.dart';
import 'package:clinica_medica/infra/atendente_connect.dart';
import 'package:clinica_medica/infra/medico_connect.dart';
import 'package:clinica_medica/infra/endereco_connect.dart';
import 'package:clinica_medica/infra/especialidade_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FuncionarioController {
  FuncionarioFB funcionarioFB = new FuncionarioFB();
  AtendenteFB atendenteFB = new AtendenteFB();
  MedicoFB medicoFB = new MedicoFB();
  EnderecoFB enderecoFB = new EnderecoFB();
  EspecialidadeFB especialidadeFB = new EspecialidadeFB();

  Future<void> createFuncAtendente(authData, userCredential, salario, turno,
      cep, cidade, estado, logradouro, numero) async {
    try {
      await enderecoFB.create(cep, cidade, estado, logradouro, numero);
      DocumentReference enderecoId = enderecoFB.getDocRef(cidade, cep, numero);
      await funcionarioFB.create(authData, userCredential, enderecoId);
      await atendenteFB.create(salario, userCredential.user.uid, turno);
    } catch (err) {
      print(err);
    }
  }

  Future<void> createfuncMedico(authData, userCredential, cep, cidade, estado,
      logradouro, numero, nomeEspecialidade, salario, crm) async {
    try {
      await enderecoFB.create(cep, cidade, estado, logradouro, numero);
      await especialidadeFB.create(nomeEspecialidade);
      DocumentReference enderecoId = enderecoFB.getDocRef(cidade, cep, numero);
      DocumentReference especialidade =
          especialidadeFB.getDocRef(nomeEspecialidade);
      await funcionarioFB.create(authData, userCredential, enderecoId);
      await medicoFB.create(
          crm, userCredential.user.uid, salario, especialidade);
    } catch (err) {
      print(err);
    }
  }

  Future<void> update(
      authData, funcionarioId, enderecoId, especialidadeId) async {
    await funcionarioFB.update(authData, funcionarioId, enderecoId);
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
