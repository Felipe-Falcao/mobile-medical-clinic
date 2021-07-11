import 'package:clinica_medica/controllers/endereco_controller.dart';
import 'package:clinica_medica/controllers/funcionario_controller.dart';
import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/atendente_data.dart';
import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/endereco_data.dart';
import 'package:clinica_medica/models/funcionario_data.dart';
import 'package:flutter/material.dart';

class AttendantProvider extends ChangeNotifier {
  FuncionarioController funcionarioController = FuncionarioController();
  EnderecoController enderecoController = EnderecoController();
  AuthenticationFB authenticationFB = AuthenticationFB();

  List<Attendant> _items = [];

  List<Attendant> get items {
    return [..._items];
  }

  List<Attendant> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();

    return _items
        .where((attendant) =>
            attendant.employee.name.toLowerCase().contains(filter))
        .toList();
  }

  Attendant getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadAttendants() async {
    List<dynamic> attendantList =
        await funcionarioController.buscarAtendentes();

    _items.clear();

    for (var i = 0; i < attendantList.length; i++) {
      var attendantEmployee = attendantList[i]['refFuncionario'];

      Map<String, dynamic> funcionario =
          await funcionarioController.buscarFuncionario(attendantEmployee);

      var addressEmployee = funcionario['refEndereco'].id;
      //print(addressEmployee);

      Map<String, dynamic> enderecoMap =
          await enderecoController.buscarEndereco(addressEmployee);

      Address address = Address(
          id: funcionario['refEndereco'].id,
          street: enderecoMap['logradouro'],
          number: enderecoMap['numero'],
          zipCode: enderecoMap['CEP'],
          city: enderecoMap['cidade'],
          state: enderecoMap['estado']);

      Employee employee = Employee(
          id: attendantList[i]['refFuncionario'],
          workCard: funcionario['carteiraTrabalho'],
          hiringDate: DateTime.fromMicrosecondsSinceEpoch(
              funcionario['dataContratacao'].microsecondsSinceEpoch),
          email: funcionario['email'],
          name: funcionario['nome'],
          phoneNumber: funcionario['telefone'],
          cpf: funcionario['cpf'],
          password: funcionario['senha'],
          address: address);

      Attendant attendant = Attendant(
          id: attendantList[i]['id'],
          employee: employee,
          salary: double.parse(attendantList[i]['salario']),
          rotation: attendantList[i]['turno']);

      _items.add(attendant);
    }

    notifyListeners();
  }

  Future<void> addAttendant(Attendant attendant) async {
    if (attendant == null) return;

    InfoEndereco infoEndereco = InfoEndereco();
    infoEndereco.logradouro = attendant.employee.address.street;
    infoEndereco.numero = attendant.employee.address.number;
    infoEndereco.cep = attendant.employee.address.zipCode;
    infoEndereco.cidade = attendant.employee.address.city;
    infoEndereco.estado = attendant.employee.address.state;

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.nome = attendant.employee.name;
    infoFuncionario.cpf = attendant.employee.cpf;
    infoFuncionario.email = attendant.employee.email;
    infoFuncionario.carteiraTrabalho = attendant.employee.workCard;
    infoFuncionario.dataContratacao = attendant.employee.hiringDate;
    infoFuncionario.telefone = attendant.employee.phoneNumber;
    infoFuncionario.senha = attendant.employee.password;
    infoFuncionario.tipo = attendant.type;

    InfoAtendente infoAtendente = InfoAtendente();
    infoAtendente.salario = attendant.salary.toString();
    infoAtendente.turno = attendant.rotation;

    await funcionarioController.cadastrarAtendente(
        infoFuncionario, infoAtendente, infoEndereco);

    await loadAttendants();
  }

  Future<void> updateAttendant(Attendant attendant) async {
    if (attendant == null || attendant.id == null) {
      return;
    }

    InfoEndereco infoEndereco = InfoEndereco();
    infoEndereco.id = attendant.employee.address.id;
    infoEndereco.logradouro = attendant.employee.address.street;
    infoEndereco.numero = attendant.employee.address.number;
    infoEndereco.cep = attendant.employee.address.zipCode;
    infoEndereco.cidade = attendant.employee.address.city;
    infoEndereco.estado = attendant.employee.address.state;

    await enderecoController.atualizarEndereco(infoEndereco);

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.id = attendant.employee.id;
    infoFuncionario.nome = attendant.employee.name;
    infoFuncionario.cpf = attendant.employee.cpf;
    infoFuncionario.email = attendant.employee.email;
    infoFuncionario.carteiraTrabalho = attendant.employee.workCard;
    infoFuncionario.dataContratacao = attendant.employee.hiringDate;
    infoFuncionario.telefone = attendant.employee.phoneNumber;
    infoFuncionario.senha = attendant.employee.password;

    await funcionarioController.editarDadosPessoais(infoFuncionario);
    await funcionarioController.editarDadosTrabalho(infoFuncionario);

    InfoAtendente infoAtendente = InfoAtendente();
    infoAtendente.id = attendant.id;
    infoAtendente.salario = attendant.salary.toString();
    infoAtendente.turno = attendant.rotation;

    await funcionarioController.editarAtendente(infoAtendente);

    await loadAttendants();
  }

  Future<void> removeAttendant(Attendant attendant) async {
    if (attendant == null) return;

    InfoAtendente infoAtendente = InfoAtendente();
    infoAtendente.id = attendant.id;

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.id = attendant.employee.id;
    infoFuncionario.refEndereco = attendant.employee.address.id;

    await funcionarioController.excluirAtendente(
        infoAtendente, infoFuncionario);

    _items.remove(attendant);
    notifyListeners();
  }
}
