import 'package:clinica_medica/infra/medico_connect.dart';
import 'package:clinica_medica/infra/paciente_connect.dart';
import 'package:clinica_medica/infra/medicamento_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Classe responsável por realizar o controle das requisições de Paciente,
 * Médico e Medicamentos da camada de Infra.
 */
class MedicamentoController {
  PacienteFB pacienteFB = new PacienteFB();
  MedicoFB medicoFB = new MedicoFB();
  MedicamentoFB medicamentoFB = new MedicamentoFB();

  /*
   * Função responsável por receber dados de medicamento e chamar as funções 
   * de criação de medicamento.
   */
  Future<void> cadastrarMedicamento(
      infoMedicamento, pacienteId, medicoId) async {
    try {
      medicamentoFB.create(infoMedicamento.dataPrescricao, infoMedicamento.dose,
          infoMedicamento.nome, medicoId, pacienteId);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por chamar as funções de busca de medicamentos, 
   * montar um Map de Strings. Retorna o Map obtido com cada medicamento existente.
   */
  Future<List<dynamic>> buscarMedicamentos() async {
    var result = [];
    var data;
    QuerySnapshot medicamentos = await medicamentoFB.getMedicamentos();

    for (int i = 0; i < medicamentos.size; i++) {
      data = medicamentos.docs[i].data();
      result.add({
        'id': medicamentos.docs[i].id,
        'dataPrescricao': data['dataPrescricao'],
        'dose': data['dose'],
        'nome': data['nome'],
        'refMedico': data['refMedico'],
        'refPaciente': data['refPaciente'],
      });
    }
    return result;
  }

  /*
   * Função responsável por receber dados de medicamento e chamar as funções 
   * de atualização de dados do medicamento.
   */
  Future<void> editarMedicamento(infoMedicamento) async {
    try {
      medicamentoFB.update(infoMedicamento.dataPrescricao, infoMedicamento.dose,
          infoMedicamento.nome, infoMedicamento.id);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber um id de medicamento e chamar as funções 
   * de exclusão de dados de medicamento. 
   */
  Future<void> excluirMedicamento(medicamentoId) async {
    try {
      medicamentoFB.delete(medicamentoId);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber um id de medicamento e retornar os dados
   * de medicamento em Map de strings.
   */
  Future<Map<String, dynamic>> buscarMedicamento(medicamentoId) async {
    try {
      return await medicamentoFB.read(medicamentoId);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
