import 'package:clinica_medica/controllers/endereco_controller.dart';
import 'package:clinica_medica/controllers/funcionario_controller.dart';
import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/atendente_data.dart';
import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/endereco_data.dart';
import 'package:clinica_medica/models/funcionario_data.dart';
import 'package:flutter/material.dart';

// Classe responsável por gerenciar a comunicação entre as telas
//\\e os controllers de atendente
class AttendantProvider extends ChangeNotifier {
  FuncionarioController funcionarioController = FuncionarioController();
  EnderecoController enderecoController = EnderecoController();

  // cria lista de atendentes
  List<Attendant> _items = [];

  // função que retorna todos os items da lista de atendente
  List<Attendant> get items {
    return [..._items];
  }

  //função que retorna os items da lista filtrados por nome de atendente
  List<Attendant> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();

    return _items
        .where((attendant) =>
            attendant.employee.name.toLowerCase().contains(filter))
        .toList();
  }

  // função que pesquisa um atendente pelo id
  Attendant getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  //função que retorna a quantidade de items da lista de atendentes
  int get itemsCount {
    return _items.length;
  }

  // função que carrega todos os registros de atendente do banco
  Future<void> loadAttendants() async {
    //lista do tipo dynamic que recebe os registro de atendente do banco
    List<dynamic> attendantList =
        await funcionarioController.buscarAtendentes();

    _items.clear();

    // trecho de código que converte os dados de um registro do tipo dynamic
    // para seus respectivos tipos como Endereço, Funcionário e Atendente
    for (var i = 0; i < attendantList.length; i++) {
      var attendantEmployee = attendantList[i]['refFuncionario'];

      Map<String, dynamic> funcionario =
          await funcionarioController.buscarFuncionario(attendantEmployee);

      var addressEmployee = funcionario['refEndereco'].id;

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

      //adiciona os items do banco a lista de atendentes criada anteriormente
      _items.add(attendant);
    }

    //envia para uma notificação para as telas que usam essa função
    // alertando sobre alguma mudança
    notifyListeners();
  }

  // função que cadastra um atendente
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

    //função do controller de funcionario para cadastrar o atendente
    await funcionarioController.cadastrarAtendente(
        infoFuncionario, infoAtendente, infoEndereco);

    //função que carrega os registros do banco
    await loadAttendants();
  }

  // função que atualiza um atendente
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

    //função do controller de endereco que edita os dados de endereco
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

    //função do controller de funcionario que edita apenas as informações
    //pessoais do funcionário
    await funcionarioController.editarDadosPessoais(infoFuncionario);

    //função do controller de funcionario que edita apenas as informações
    //trabalhistas do funcionario
    await funcionarioController.editarDadosTrabalho(infoFuncionario);

    InfoAtendente infoAtendente = InfoAtendente();
    infoAtendente.id = attendant.id;
    infoAtendente.salario = attendant.salary.toString();
    infoAtendente.turno = attendant.rotation;

    //função do controller de funcionario que edita apenas as informações
    //relacionadas a atendente
    await funcionarioController.editarAtendente(infoAtendente);

    //função que carrega os registros de atendente do banco
    await loadAttendants();
  }

  //função que exclui um atendente
  Future<void> removeAttendant(Attendant attendant) async {
    if (attendant == null) return;

    InfoAtendente infoAtendente = InfoAtendente();
    infoAtendente.id = attendant.id;

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.id = attendant.employee.id;
    infoFuncionario.refEndereco = attendant.employee.address.id;

    //função do controller de funcionario que exclui o atendente e
    //sua referência na tabela funcionario e endereço
    await funcionarioController.excluirAtendente(
        infoAtendente, infoFuncionario);

    //remove o item da lista
    _items.remove(attendant);

    //envia para uma notificação para as telas que usam essa função
    // alertando sobre alguma mudança
    notifyListeners();
  }
}
