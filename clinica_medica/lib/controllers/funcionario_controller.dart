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

  Future<void> cadastrarAtendente(
      infoFuncionario, infoAtendente, infoEndereco) async {
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
      // Cadastrar Atendente
      await atendenteFB.create(
          infoAtendente.salario, funcionarioId, infoAtendente.turno);
    } catch (err) {
      print(err);
    }
  }

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

  Future<List<dynamic>> buscarFuncionarios() async {
    var result = [];
    var data;
    QuerySnapshot funcionarios = await funcionarioFB.getFuncionarios();

    for (int i = 0; i < funcionarios.size; i++) {
      data = funcionarios.docs[i].data();
      result.add([
        funcionarios.docs[i].id,
        data['email'],
        data['carteiraTrabalho'],
        data['cpf'],
        data['refEndereco'].id,
        data['dataContratacao'],
        data['nome'],
        data['telefone'],
      ]);
    }
    return result;
  }

  Future<void> atualizarEndereco(infoEndereco) async {
    try {
      await enderecoFB.update(
          infoEndereco.cep,
          infoEndereco.cidade,
          infoEndereco.estado,
          infoEndereco.logradouro,
          infoEndereco.numero,
          infoEndereco.id);
    } catch (err) {
      print(err);
    }
  }

  void editarDadosPessoais(infoFuncionario) {
    funcionarioFB.updatePersonalData(infoFuncionario);
  }

  void editarDadosTrabalho(infoFuncionario) {
    funcionarioFB.updateWorkData(infoFuncionario.carteiraTrabalho,
        infoFuncionario.dataContratacao, infoFuncionario.id);
  }

  Future<void> editarAtendente(
      infoFuncionario, infoMedico, infoEndereco) async {
    try {} catch (err) {
      print(err);
    }
  }
}
