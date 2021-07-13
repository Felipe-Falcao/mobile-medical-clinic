import 'package:clinica_medica/infra/prontuario_connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Classe responsável por realizar o controle das requisições de Prontuário da 
 * camada de Infra.
 */
class ProntuarioController {
  ProntuarioFB prontuarioFB = new ProntuarioFB();

  /*
   * Função responsável por receber dados de prontuário e chamar as funções de 
   * criação de prontuário.
   */
  Future<void> cadastrarProntuario(infoProntuario) async {
    try {
      await prontuarioFB.create(
        infoProntuario.refPaciente,
        // infoProntuario.refMedicamento,
        infoProntuario.nota,
      );
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por chamar as funções de busca de prontuarios, 
   * montar um Map de Strings. Retorna o Map obtido com cada prontuario existente.
   */
  Future<List<Map<String, dynamic>>> buscarProntuarios() async {
    List<Map<String, dynamic>> result = [];
    var data;
    QuerySnapshot prontuarios = await prontuarioFB.getProntuarios();

    for (int i = 0; i < prontuarios.size; i++) {
      data = prontuarios.docs[i].data();
      result.add({
        'id': prontuarios.docs[i].id,
        'dataAtualizacao': data['dataAtualizacao'],
        'dataCadastro': data['dataCadastro'],
        'nota': data['nota'],
        // 'refMedicamento': data['refMedicamento'].id,
        'refPaciente': data['refPaciente'].id,
      });
    }
    return result;
  }

  /*
   * Função responsável por receber dados de prontuário e chamar as funções 
   * de atualização de dados do prontuário.
   */
  Future<void> editarProntuario(infoProntuario) async {
    await prontuarioFB.update(
      // infoProntuario.refMedicamento,
      infoProntuario.id,
      infoProntuario.nota,
    );
  }

  /*
   * Função responsável por receber dados de prontuário e chamar as funções 
   * de exclusão de dados de prontuário. 
   */
  Future<void> excluirProntuario(prontuarioId) async {
    try {
      prontuarioFB.delete(prontuarioId);
    } catch (err) {
      print(err);
    }
  }

  /*
   * Função responsável por receber um id de prontuário e  chamar a função 
   * de busca de prontuário. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarProntuario(prontuarioId) async {
    try {
      return await prontuarioFB.read(prontuarioId);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
