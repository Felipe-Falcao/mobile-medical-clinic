import 'package:clinica_medica/controllers/endereco_controller.dart';
import 'package:clinica_medica/controllers/funcionario_controller.dart';
import 'package:clinica_medica/infra/auth_connect.dart';

import 'package:clinica_medica/models/address.dart';

import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/endereco_data.dart';
import 'package:clinica_medica/models/funcionario_data.dart';
import 'package:clinica_medica/models/medico_data.dart';
import 'package:clinica_medica/models/specialty.dart';
import 'package:flutter/material.dart';

// Classe responsável por gerenciar a comunicação entre as telas
// e os controllers de médico
class DoctorProvider extends ChangeNotifier {
  FuncionarioController funcionarioController = FuncionarioController();
  EnderecoController enderecoController = EnderecoController();

  //cria lista de médicos
  List<Doctor> _items = [];

  //cria lista de especialidades
  List<Specialty> specialties = [];

  //função que retorna todos os items da lista de médico
  List<Doctor> get items {
    return [..._items];
  }

  //função que retorna todos os items da lista de especialidade
  List<Specialty> get itemsSpecialty {
    return [...specialties];
  }

  //função que retorna os items da lista de médico filtrados pelo nome ou
  //pela especialidade
  List<Doctor> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();

    return _items
        .where((doctor) =>
            doctor.employee.name.toLowerCase().contains(filter) ||
            doctor.specialty.name.toLowerCase().contains(filter))
        .toList();
  }

  //função que pesquisa um médico pelo id
  Doctor getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  //função que retorna a quantidade de items da lista de médicos
  int get itemsCount {
    return _items.length;
  }

  //função que carrega os registros de especialidade do banco
  Future<void> loadSpecialties() async {
    //lista do tipo dynamic que recebe os registros do banco
    List<dynamic> specialtyList =
        await funcionarioController.buscarEspecialidades();

    specialties.clear();

    //trecho de código que converte os registros dynamic para
    //o tipo especialidade
    for (var i = 0; i < specialtyList.length; i++) {
      Specialty specialty = Specialty(
          id: specialtyList[i]['id'],
          name: specialtyList[i]['nomeEspecialidade']);

      //adiciona os items na lista de especialidades
      specialties.add(specialty);
    }
  }

  //função que carrega os registros de médico do banco
  Future<void> loadDoctors() async {
    //lista do tipo dynamic que recebe os registros do banco
    List<dynamic> doctorList = await funcionarioController.buscarMedicos();

    _items.clear();

    // trecho de código que converte os dados de um registro do tipo dynamic
    // para seus respectivos tipos como Endereço, Funcionário e Médico
    for (var i = 0; i < doctorList.length; i++) {
      var doctorEmployee = doctorList[i]['refFuncionario'];

      Map<String, dynamic> funcionario =
          await funcionarioController.buscarFuncionario(doctorEmployee);

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
          id: doctorList[i]['refFuncionario'],
          workCard: funcionario['carteiraTrabalho'],
          hiringDate: DateTime.fromMicrosecondsSinceEpoch(
              funcionario['dataContratacao'].microsecondsSinceEpoch),
          email: funcionario['email'],
          name: funcionario['nome'],
          phoneNumber: funcionario['telefone'],
          cpf: funcionario['cpf'],
          password: funcionario['senha'],
          address: address);

      Specialty specialty = Specialty(name: doctorList[i]['refEspecialidade']);

      Doctor doctor = Doctor(
          id: doctorList[i]['id'],
          crm: doctorList[i]['crm'],
          salary: double.parse(doctorList[i]['salario']),
          employee: employee,
          specialty: specialty);

      //adiciona os items na lista de médico
      _items.add(doctor);
    }
    //função que carrega os registros de especialidade do banco
    loadSpecialties();

    //envia para uma notificação para as telas que usam essa função
    // alertando sobre alguma mudança
    notifyListeners();
  }

  //função que cadastra um médico
  Future<void> addDoctor(Doctor doctor) async {
    if (doctor == null) return;

    InfoMedico infoMedico = InfoMedico();
    infoMedico.crm = doctor.crm;
    infoMedico.salario = doctor.salary.toString();
    infoMedico.nomeEspecialidade = doctor.specialty.name;

    InfoEndereco infoEndereco = InfoEndereco();
    infoEndereco.logradouro = doctor.employee.address.street;
    infoEndereco.numero = doctor.employee.address.number;
    infoEndereco.cep = doctor.employee.address.zipCode;
    infoEndereco.cidade = doctor.employee.address.city;
    infoEndereco.estado = doctor.employee.address.state;

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.nome = doctor.employee.name;
    infoFuncionario.cpf = doctor.employee.cpf;
    infoFuncionario.email = doctor.employee.email;
    infoFuncionario.carteiraTrabalho = doctor.employee.workCard;
    infoFuncionario.dataContratacao = doctor.employee.hiringDate;
    infoFuncionario.telefone = doctor.employee.phoneNumber;
    infoFuncionario.senha = doctor.employee.password;
    infoFuncionario.tipo = doctor.type;

    //função do controller de funcionario para cadastrar um médico
    await funcionarioController.cadastrarMedico(
        infoFuncionario, infoMedico, infoEndereco);

    //função que carrega os registros de médico do banco
    await loadDoctors();
  }

  //função que atualiza um médico
  Future<void> updateDoctor(Doctor doctor) async {
    if (doctor == null || doctor.id == null) {
      return;
    }

    InfoEndereco infoEndereco = InfoEndereco();
    infoEndereco.id = doctor.employee.address.id;
    infoEndereco.logradouro = doctor.employee.address.street;
    infoEndereco.numero = doctor.employee.address.number;
    infoEndereco.cep = doctor.employee.address.zipCode;
    infoEndereco.cidade = doctor.employee.address.city;
    infoEndereco.estado = doctor.employee.address.state;

    //função do controller de endereco que edita os dados de endereco
    await enderecoController.atualizarEndereco(infoEndereco);

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.id = doctor.employee.id;
    infoFuncionario.nome = doctor.employee.name;
    infoFuncionario.cpf = doctor.employee.cpf;
    infoFuncionario.email = doctor.employee.email;
    infoFuncionario.carteiraTrabalho = doctor.employee.workCard;
    infoFuncionario.dataContratacao = doctor.employee.hiringDate;
    infoFuncionario.telefone = doctor.employee.phoneNumber;
    infoFuncionario.senha = doctor.employee.password;

    //função do controller de funcionario que edita apenas as informações
    //pessoais do médico
    await funcionarioController.editarDadosPessoais(infoFuncionario);
    //função do controller de funcionario que edita apenas as informações
    //trabalhistas do médico
    await funcionarioController.editarDadosTrabalho(infoFuncionario);

    InfoMedico infoMedico = InfoMedico();
    infoMedico.id = doctor.id;
    infoMedico.crm = doctor.crm;
    infoMedico.salario = doctor.salary.toString();
    infoMedico.nomeEspecialidade = doctor.specialty.name;

    //função do controller de funcionario que edita apenas as informações
    //relacionadas a médico
    await funcionarioController.editarMedico(infoMedico);

    //função carrega os registros de médico do banco
    await loadDoctors();
  }

  //função que exclui um médico
  Future<void> removeDoctor(Doctor doctor) async {
    if (doctor == null) return;

    InfoMedico infoMedico = InfoMedico();
    infoMedico.id = doctor.id;

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.id = doctor.employee.id;
    infoFuncionario.refEndereco = doctor.employee.address.id;

    //função do controller de funcionario que exclui o médico e
    //sua referência na tabela funcionario e endereço
    await funcionarioController.excluirMedico(infoMedico, infoFuncionario);

    //remove o item excluído da lista
    _items.remove(doctor);

    //envia para uma notificação para as telas que usam essa função
    // alertando sobre alguma mudança
    notifyListeners();
  }
}
