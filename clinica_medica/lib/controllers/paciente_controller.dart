import 'package:clinica_medica/infra/endereco_connect.dart';
import 'package:clinica_medica/infra/paciente_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Classe responsável por realizar o controle das requisições de Paciente e
 * Endereço da camada de Infra.
 */
class PacienteController {
  PacienteFB pacienteFB = new PacienteFB();
  EnderecoFB enderecoFB = new EnderecoFB();

  /*
   * Função responsável por receber dados de paciente e endereço
   * e chamar as funções de criação de endereço e paciente.
   */
  Future<void> cadastrarPaciente(infoPaciente, infoEndereco) async {
    try {
      // Cadastrar endereço
      await enderecoFB.create(infoEndereco.cep, infoEndereco.cidade,
          infoEndereco.estado, infoEndereco.logradouro, infoEndereco.numero);
      // Obter referência de endereço
      DocumentReference enderecoId = enderecoFB.getDocRef(
          infoEndereco.cidade, infoEndereco.cep, infoEndereco.numero);
      // Cadastrar Paciente
      await pacienteFB.create(infoPaciente.cpf, infoPaciente.dataNascimento,
          infoPaciente.nome, enderecoId.id, infoPaciente.telefone);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por chamar as funções de busca de pacientes, 
   * montar um Map de Strings. Retorna o Map obtido com cada paciente existente.
   */
  Future<List<Map<String, dynamic>>> buscarPacientes() async {
    List<Map<String, dynamic>> result = [];
    var data;
    QuerySnapshot pacientes = await pacienteFB.getPacientes();

    for (int i = 0; i < pacientes.size; i++) {
      data = pacientes.docs[i].data();
      result.add({
        'id': pacientes.docs[i].id,
        'cpf': data['cpf'],
        'dataNascimento': data['dataNascimento'],
        'nome': data['nome'],
        'refEndereco': data['refEndereco'].id,
        'telefone': data['telefone'],
      });
    }
    return result;
  }

  /*
   * Função responsável por receber dados de paciente e chamar as funções 
   * de atualização de dados do paciente.
   */
  Future<void> editarPaciente(infoPaciente) async {
    try {
      await pacienteFB.update(infoPaciente.cpf, infoPaciente.dataNascimento,
          infoPaciente.nome, infoPaciente.telefone, infoPaciente.id);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber dados de paciente e chamar as funções 
   * de exclusão de dados de paciente e endereço. 
   */
  Future<void> excluirPaciente(infoPaciente) async {
    try {
      // Excluir paciente
      await pacienteFB.delete(infoPaciente.id);
      // Excluir endereco
      await enderecoFB.delete(infoPaciente.refEndereco);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber um id de paciente e retornar os dados
   * de paciente em Map de Strings.
   */
  Future<Map<String, dynamic>> buscarPaciente(pacienteId) async {
    try {
      return await pacienteFB.read(pacienteId);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
