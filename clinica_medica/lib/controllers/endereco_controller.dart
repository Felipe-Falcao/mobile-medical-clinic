import 'package:clinica_medica/infra/endereco_connect.dart';

class EnderecoController {
  EnderecoFB enderecoFB = new EnderecoFB();

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

  Future<Map<String, dynamic>> buscarEndereco(enderecoId) async {
    try {
      return await enderecoFB.read(enderecoId);
    } catch (err) {
      print(err);
      return null;
    }
  }
}
