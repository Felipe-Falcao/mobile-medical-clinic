import 'package:clinica_medica/infra/agendamento_connect.dart';

class AgendamentoController {
  AgendamentoFB agendamentoFB = new AgendamentoFB();

  Future<void> create(data, atendenteId, tipo) async {
    await agendamentoFB.create(data, atendenteId, tipo);
  }

  Future<void> update(data, atendenteId, tipo, agendamentoId) async {
    await agendamentoFB.update(data, atendenteId, tipo, agendamentoId);
  }

  Future<void> delete(agendamentoId) async {
    await agendamentoFB.delete(agendamentoId);
  }

  Future<Map<String, dynamic>> read(agendamentoId) async {
    return await agendamentoFB.read(agendamentoId);
  }
}

// TESTES
// AgendamentoController agendamentoController =
//     new AgendamentoController();
// CREATE
// await agendamentoController.create(
//     DateTime.now(), 'DJrMeRBIOT2OkvVCac68', 'Exame');
// UPDATE
// await agendamentoController.update(DateTime.now(),
//     'DJrMeRBIOT2OkvVCac68', 'Consulta', '8DTO7LMwe6Yif7B8xFY5');
// READ
// var a = await agendamentoController.read('8DTO7LMwe6Yif7B8xFY5');
// print(a);
//DELETE
// await agendamentoController.delete('');
