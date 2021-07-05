import 'dart:math';

import 'package:clinica_medica/controllers/endereco_controller.dart';
import 'package:clinica_medica/controllers/funcionario_controller.dart';
import 'package:clinica_medica/data/doctor_data.dart';
import 'package:clinica_medica/models/address.dart';
//import 'package:clinica_medica/data/doctor_data.dart';
import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/endereco_data.dart';
import 'package:clinica_medica/models/funcionario_data.dart';
import 'package:clinica_medica/models/medico_data.dart';
import 'package:clinica_medica/models/specialty.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  FuncionarioController funcionarioController = FuncionarioController();
  EnderecoController enderecoController = EnderecoController();

  List<Doctor> _items = [];

  List<Doctor> get items {
    return [..._items];
  }

  List<Doctor> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();

    return _items
        .where((doctor) =>
            doctor.employee.name.toLowerCase().contains(filter) ||
            doctor.specialty.name.toLowerCase().contains(filter))
        .toList();
  }

  Doctor getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadDoctors() async {
    List<dynamic> doctorList = await funcionarioController.buscarMedicos();

    _items.clear();

    for (var i = 0; i < doctorList.length; i++) {
      List<dynamic> funcionarios =
          await funcionarioController.buscarFuncionarios();

      dynamic funcionario;

      for (var j = 0; j < funcionarios.length; j++) {
        if (funcionarios[j]['id'] == doctorList[i]['refFuncionario']) {
          print('entrei aqui');
          funcionario = funcionarios[i];
          Map<String, dynamic> enderecoMap = await enderecoController
              .buscarEndereco(funcionario['refEndereco']);

          Address address = Address(
              id: funcionario['refEndereco'],
              street: enderecoMap['logradouro'],
              number: enderecoMap['numero'],
              zipCode: enderecoMap['CEP'],
              city: enderecoMap['cidade'],
              state: enderecoMap['estado']);

          Employee employee = Employee(
              workCard: funcionario['carteiraTrabalho'],
              hiringDate: DateTime.fromMicrosecondsSinceEpoch(
                  funcionario['dataContratacao'].microsecondsSinceEpoch),
              email: funcionario['email'],
              name: funcionario['nome'],
              phoneNumber: funcionario['telefone'],
              cpf: funcionario['cpf'],
              password: funcionario['senha'],
              address: address);

          Specialty specialty =
              Specialty(name: doctorList[i]['refEspecialidade']);

          Doctor doctor = Doctor(
              crm: doctorList[i]['crm'],
              salary: double.parse(doctorList[i]['salario']),
              employee: employee,
              specialty: specialty);

          _items.add(doctor);
        } else {
          return null;
        }
      }
    }

    notifyListeners();
  }

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

    await funcionarioController.cadastrarMedico(
        infoFuncionario, infoMedico, infoEndereco);

    await loadDoctors();

    /*_items.add(Doctor(
        id: Random().nextDouble().toString(),
        crm: doctor.crm,
        salary: doctor.salary,
        employee: doctor.employee,
        specialty: doctor.specialty));

    notifyListeners();*/
  }

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

    funcionarioController.editarDadosPessoais(infoFuncionario);
    funcionarioController.editarDadosTrabalho(infoFuncionario);

    InfoMedico infoMedico = InfoMedico();
    infoMedico.id = doctor.id;
    infoMedico.crm = doctor.crm;
    infoMedico.salario = doctor.salary.toString();
    infoMedico.nomeEspecialidade = doctor.specialty.name;

    await funcionarioController.editarMedico(infoMedico);

    //await loadDoctors();

    /*final index = _items.indexWhere((prod) => prod.id == doctor.id);
    if (index >= 0) {
      _items[index] = doctor;
      notifyListeners();
    }*/
  }

  Future<void> removeDoctor(Doctor doctor) async {
    if (doctor == null) return;

    InfoMedico infoMedico = InfoMedico();
    infoMedico.id = doctor.id;

    InfoFuncionario infoFuncionario = InfoFuncionario();
    infoFuncionario.id = doctor.employee.id;
    infoFuncionario.refEndereco = doctor.employee.address.id;

    await funcionarioController.excluirMedico(infoMedico, infoFuncionario);

    _items.remove(doctor);
    notifyListeners();
  }
}
