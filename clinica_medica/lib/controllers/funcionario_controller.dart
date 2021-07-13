import 'package:clinica_medica/infra/funcionario_connect.dart';
import 'package:clinica_medica/infra/atendente_connect.dart';
import 'package:clinica_medica/infra/medico_connect.dart';
import 'package:clinica_medica/infra/endereco_connect.dart';
import 'package:clinica_medica/infra/especialidade_connect.dart';
import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
 * Classe responsável por realizar o controle das requisições de Funcionário,
 * Atendente, Médico, Endereço, Especialidade e Autenticação da camada de Infra.
 */
class FuncionarioController {
  FuncionarioFB funcionarioFB = new FuncionarioFB();
  AtendenteFB atendenteFB = new AtendenteFB();
  MedicoFB medicoFB = new MedicoFB();
  EnderecoFB enderecoFB = new EnderecoFB();
  EspecialidadeFB especialidadeFB = new EspecialidadeFB();
  AuthenticationFB auth = new AuthenticationFB();
  UserCredential userCredential;

  /*
   * Função responsável por receber dados de funcionário, atendente e endereço
   * e chamar as funções de criação de usuário, endereço, funcionário e atendente.
   */
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

  /*
   * Função responsável por receber dados de funcionário, médico e endereço
   * e chamar as funções de criação de usuário, endereço, funcionário e médico.
   */
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

  /*
   * Função responsável por chamar as funções de busca de funcionários, 
   * montar um Map de Strings. Retorna o Map obtido com cada funcionário existente.
   */
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

  /*
   * Função responsável por chamar as funções de busca de médicos, 
   * montar um Map de Strings. Retorna o Map obtido com cada médico existente.
   */
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

  /*
   * Função responsável por chamar as funções de busca de atendentes, 
   * montar um Map de Strings. Retorna o Map obtido com cada atendente existente.
   */
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

  /*
   * Função responsável por receber dados de funcionário e chamar as funções 
   * de atualização de dados do funcionário.
   */
  Future<void> editarDadosPessoais(infoFuncionario) async {
    try {
      funcionarioFB.updatePersonalData(infoFuncionario);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber dados de funcionário e chamar as funções 
   * de atualização de dados de trabalho.
   */
  Future<void> editarDadosTrabalho(infoFuncionario) async {
    try {
      funcionarioFB.updateWorkData(infoFuncionario.carteiraTrabalho,
          infoFuncionario.dataContratacao, infoFuncionario.id);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber dados de atendente e chamar as funções 
   * de atualização de dados do atendente.
   */
  Future<void> editarAtendente(infoAtendente) async {
    try {
      await atendenteFB.update(
          infoAtendente.salario, infoAtendente.turno, infoAtendente.id);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber dados de médico e chamar as funções 
   * de atualização de dados do médico.
   */
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

  /*
   * Função responsável por receber dados de médico e funcionário e chamar as funções 
   * de exclusão de dados de funcionário, médico e endereço. 
   */
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

  /*
   * Função responsável por receber dados de atendente e funcionário e chamar as funções 
   * de exclusão de dados de funcionário, atendente e endereço. 
   */
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

  /*
   * Função responsável por receber um id de funcionário e retornar o tipo
   * de funcionário (admin, atendente ou médico).
   */
  Future<String> buscarTipoFuncionario(funcionarioId) async {
    var funcionario = await funcionarioFB.read(funcionarioId);
    return funcionario['tipoFuncionario'];
  }

  /*
   * Função responsável por receber um id de funcionario e  chamar a função 
   * de busca de funcionario. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarFuncionario(funcionarioId) async {
    try {
      var funcionario = await funcionarioFB.read(funcionarioId);
      return funcionario;
    } catch (err) {
      print(err);
      return null;
    }
  }

  /*
   * Função responsável por receber um id de médico e  chamar a função 
   * de busca de médico. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarMedico(medicoId) async {
    try {
      var medico = await medicoFB.read(medicoId);
      return medico;
    } catch (err) {
      print(err);
      return null;
    }
  }

  /*
   * Função responsável por receber um id de atendente e  chamar a função 
   * de busca de atendente. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarAtendente(atendenteId) async {
    try {
      return await atendenteFB.read(atendenteId);
    } catch (err) {
      print(err);
      return null;
    }
  }

  /*
   * Função responsável por chamar as funções de busca de especialidades, 
   * montar um Map de Strings. Retorna o Map obtido com cada especialidade existente.
   */
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
