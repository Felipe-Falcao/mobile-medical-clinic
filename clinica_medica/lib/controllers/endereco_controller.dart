import 'package:clinica_medica/infra/endereco_connect.dart';

/**
 * Classe responsável por realizar o controle das requisições de Endereço da 
 * camada de Infra.
 */
class EnderecoController {
  EnderecoFB enderecoFB = new EnderecoFB();

  /**
   * Função responsável por receber dados de endereço e chamar a função
   * de atualização de endereco.
   */
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

  /**
   * Função responsável por receber um id de endereço e  chamar a função 
   * de busca de endereço. Retorna um Map de strings com os valores obtidos.
   */
  Future<Map<String, dynamic>> buscarEndereco(enderecoId) async {
    try {
      return await enderecoFB.read(enderecoId);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
