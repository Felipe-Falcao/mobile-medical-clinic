import 'package:clinica_medica/infra/endereco_connect.dart';
import 'package:clinica_medica/infra/paciente_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PacienteController {
  PacienteFB pacienteFB = new PacienteFB();
  EnderecoFB enderecoFB = new EnderecoFB();

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

  Future<List<dynamic>> buscarPacientes() async {
    var result = [];
    var data;
    QuerySnapshot pacientes = await pacienteFB.getPacientes();

    for (int i = 0; i < pacientes.size; i++) {
      data = pacientes.docs[i].data();
      result.add({
        'id': pacientes.docs[i].id,
        'cpf': data['cpf'],
        'dataNascimento': data['dataNascimento'],
        'nome': data['nome'],
        'refEndereco': data['refEndereco'],
        'telefone': data['telefone'],
      });
    }
    return result;
  }

  void editarPaciente(infoPaciente) {
    pacienteFB.update(infoPaciente.cpf, infoPaciente.dataNascimento,
        infoPaciente.nome, infoPaciente.telefone, infoPaciente.id);
  }

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
}
