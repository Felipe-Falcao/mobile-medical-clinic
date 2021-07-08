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
      result.add({
        'id': funcionarios.docs[i].id,
        'email': data['email'],
        'carteiraTrabalho': data['carteiraTrabalho'],
        'cpf': data['cpf'],
        'refEndereco': data['refEndereco'].id,
        'dataContratacao': data['dataContratacao'],
        'nome': data['nome'],
        'telefone': data['telefone'],
        'tipoFuncionario': data['tipoFuncionario'],
      });
    }
    return result;
  }

  Future<List<dynamic>> buscarMedicos() async {
    var result = [];
    var data;
    QuerySnapshot medicos = await medicoFB.getMedicos();

    for (int i = 0; i < medicos.size; i++) {
      data = medicos.docs[i].data();
      result.add({
        'id': medicos.docs[i].id,
        'crm': data['crm'],
        'refEspecialidade': data['refEspecialidade'].id,
        'refFuncionario': data['refFuncionario'].id,
        'salario': data['salario'],
      });
    }
    return result;
  }

  Future<List<dynamic>> buscarAtendentes() async {
    var result = [];
    var data;
    QuerySnapshot atendentes = await atendenteFB.getAtendentes();

    for (int i = 0; i < atendentes.size; i++) {
      data = atendentes.docs[i].data();
      result.add({
        'id': atendentes.docs[i].id,
        'refFuncionario': data['refFuncionario'].id,
        'salario': data['salario'],
        'turno': data['turno'],
      });
    }
    return result;
  }

  Future<void> editarDadosPessoais(infoFuncionario) async {
    try {
      funcionarioFB.updatePersonalData(infoFuncionario);
    } catch (err) {
      print(err);
    }
  }

  Future<void> editarDadosTrabalho(infoFuncionario) async {
    try {
      funcionarioFB.updateWorkData(infoFuncionario.carteiraTrabalho,
          infoFuncionario.dataContratacao, infoFuncionario.id);
    } catch (err) {
      print(err);
    }
  }

  Future<void> editarAtendente(infoAtendente) async {
    try {
      await atendenteFB.update(
          infoAtendente.salario, infoAtendente.turno, infoAtendente.id);
    } catch (err) {
      print(err);
    }
  }

  Future<void> editarMedico(infoMedico) async {
    try {
      // Cadastrar especialidade
      await especialidadeFB.create(infoMedico.nomeEspecialidade);
      // Obter referencia especialidade
      DocumentReference especialidade =
          especialidadeFB.getDocRef(infoMedico.nomeEspecialidade);
      // Atualizar Medico
      await medicoFB.update(
          infoMedico.crm, infoMedico.salario, especialidade, infoMedico.id);
    } catch (err) {
      print(err);
    }
  }

  Future<void> excluirMedico(infoMedico, infoFuncionario) async {
    try {
      // Excluir funcionário
      await funcionarioFB.delete(infoMedico.id);
      // Excluir médico
      await medicoFB.delete(infoMedico.id);
      // Excluir endereco
      await enderecoFB.delete(infoFuncionario.refEndereco);
    } catch (err) {
      print(err);
    }
  }

  Future<void> excluirAtendente(infoAtendente, infoFuncionario) async {
    try {
      // Excluir funcionário
      await funcionarioFB.delete(infoAtendente.id);
      // Excluir atendente
      await atendenteFB.delete(infoAtendente.id);
      // Excluir endereco
      await enderecoFB.delete(infoFuncionario.refEndereco);
    } catch (err) {
      print(err);
    }
  }

  Future<String> buscarTipoFuncionario(funcionarioId) async {
    var funcionario = await funcionarioFB.read(funcionarioId);
    return funcionario['tipoFuncionario'];
  }

  Future<Map<String, dynamic>> buscarFuncionario(funcionarioId) async {
    try {
      var funcionario = await funcionarioFB.read(funcionarioId);
      return funcionario;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<Map<String, dynamic>> buscarMedico(medicoId) async {
    try {
      var medico = await medicoFB.read(medicoId);
      return medico;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<Map<String, dynamic>> buscarAtendente(atendenteId) async {
    try {
      return await atendenteFB.read(atendenteId);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<dynamic>> buscarEspecialidades() async {
    var result = [];
    var data;
    QuerySnapshot especialidades = await especialidadeFB.getEspecialidades();

    for (int i = 0; i < especialidades.size; i++) {
      data = especialidades.docs[i].data();
      result.add({
        'id': especialidades.docs[i].id,
        'nomeEspecialidade': data['nomeEspecialidade'],
      });
    }
    return result;
  }
}
