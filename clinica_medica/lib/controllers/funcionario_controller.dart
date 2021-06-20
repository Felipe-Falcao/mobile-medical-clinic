import 'package:clinica_medica/infra/funcionario_connect.dart';
import 'package:clinica_medica/infra/atendente_connect.dart';
import 'package:clinica_medica/infra/medico_connect.dart';
import 'package:clinica_medica/infra/endereco_connect.dart';
import 'package:clinica_medica/infra/especialidade_connect.dart';
import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FuncionarioController {
  FuncionarioFB funcionarioFB = new FuncionarioFB();
  AtendenteFB atendenteFB = new AtendenteFB();
  MedicoFB medicoFB = new MedicoFB();
  EnderecoFB enderecoFB = new EnderecoFB();
  EspecialidadeFB especialidadeFB = new EspecialidadeFB();
  AuthenticationFB auth = new AuthenticationFB();
  UserCredential userCredential;

  // Future<void> createFuncAtendente(authData, userCredential, salario, turno,
  //     cep, cidade, estado, logradouro, numero) async {
  //   try {
  //     // Cadastrar usuário
  //     userCredential = await auth.signUp(authData);
  //     // Cadastrar endereço

  //     // Obter referência de endereço

  //     // Cadastrar Funcionario

  //     // Obter referência de Funcionario

  //     // Cadastrar Médico
  //     await enderecoFB.create(cep, cidade, estado, logradouro, numero);
  //     DocumentReference enderecoId = enderecoFB.getDocRef(cidade, cep, numero);
  //     await funcionarioFB.create(authData, userCredential, enderecoId);
  //     await atendenteFB.create(salario, userCredential.user.uid, turno);
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  Future<void> cadastrarMedico(
      infoFuncionario, infoMedico, infoEndereco) async {
    try {
      // Cadastrar usuário
      userCredential = await auth.signUpFuncionario(infoFuncionario);
      // Cadastrar endereço
      await enderecoFB.create(infoEndereco.cep, infoEndereco.cidade,
          infoEndereco.estado, infoEndereco.logradouro, infoEndereco.numero);
      // Obter referência de endereço
      DocumentReference enderecoId = enderecoFB.getDocRef(
          infoEndereco.cidade, infoEndereco.cep, infoEndereco.numero);
      // Cadastrar Funcionario
      await funcionarioFB.create(infoFuncionario, userCredential, enderecoId);
      // Obter referência de Funcionario
      String funcionarioId =
          await funcionarioFB.getFuncionarioId(infoFuncionario.cpf);
      // Cadastrar especialidade
      await especialidadeFB.create(infoMedico.nomeEspecialidade);
      // Obter referencia especialidade
      DocumentReference especialidade =
          especialidadeFB.getDocRef(infoMedico.nomeEspecialidade);
      // Cadastrar Médico
      await medicoFB.create(
          infoMedico.crm, funcionarioId, infoMedico.salario, especialidade);
    } catch (err) {
      print(err);
    }
  }

  Future<void> update(
      infoFuncionario, funcionarioId, enderecoId, especialidadeId) async {
    await funcionarioFB.update(infoFuncionario, funcionarioId, enderecoId);
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
