import 'package:clinica_medica/controllers/endereco_controller.dart';
import 'package:clinica_medica/controllers/paciente_controller.dart';
import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/endereco_data.dart';
import 'package:clinica_medica/models/paciente_data.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:flutter/material.dart';

/*
 * Classe responsavel por fazer a comunicacao da camada View com a 
 * camada de Controle da aplicaçao em relaçao as funcionalidades de pacientes.
 */
class Patients with ChangeNotifier {
  final PacienteController _patientCtrl = PacienteController();
  final EnderecoController _addressCtrl = EnderecoController();
  List<Patient> _items = [];

  /*
  * Retorna uma lista de todos os pacientes cadastrados
  */
  List<Patient> get items => [..._items];
  int get itemsCount => _items.length;

  /*
  * Retorna um paciente dado o ID
  */
  Patient getItemById(String id) {
    return _items.singleWhere((item) => item.id == id, orElse: () => null);
  }

  /*
  * Retorna uma lista de pacientes cujos items contenha um filtro especificado.
  * Esse filtro pode ser parte do nome ou cpf do paciente.
  */
  List<Patient> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items
        .where((patient) =>
            patient.name.toLowerCase().contains(filter) ||
            patient.cpf.toLowerCase().contains(filter))
        .toList();
  }

  /*
  * Carrega os dados atualizados dos pacientes cadastrados
  */
  Future<void> loadPatients() async {
    List<Map<String, dynamic>> patientList =
        await _patientCtrl.buscarPacientes();
    _items.clear();
    for (var patientMap in patientList) {
      Map<String, dynamic> addressMap =
          await _addressCtrl.buscarEndereco(patientMap['refEndereco']);
      Address address = Address(
        id: patientMap['refEndereco'],
        street: addressMap['logradouro'],
        number: addressMap['numero'],
        zipCode: addressMap['CEP'],
        city: addressMap['cidade'],
        state: addressMap['estado'],
      );
      Patient patient = Patient(
        id: patientMap['id'],
        cpf: patientMap['cpf'],
        name: patientMap['nome'],
        phoneNumber: patientMap['telefone'],
        birthDate: DateTime.fromMicrosecondsSinceEpoch(
            patientMap['dataNascimento'].microsecondsSinceEpoch),
        address: address,
      );
      _items.add(patient);
    }
    notifyListeners();
  }

  /*
  * Cadastra um novo paciente
  */
  Future<void> addPatient(Patient patient) async {
    if (patient == null) return;
    InfoPaciente infoPaciente = InfoPaciente();
    infoPaciente.cpf = patient.cpf;
    infoPaciente.dataNascimento = patient.birthDate;
    infoPaciente.nome = patient.name;
    infoPaciente.telefone = patient.phoneNumber;
    InfoEndereco infoEndereco = InfoEndereco();
    infoEndereco.cep = patient.address.zipCode;
    infoEndereco.cidade = patient.address.city;
    infoEndereco.estado = patient.address.state;
    infoEndereco.logradouro = patient.address.street;
    infoEndereco.numero = patient.address.number;
    await _patientCtrl.cadastrarPaciente(infoPaciente, infoEndereco);
    await loadPatients();
  }

  /*
  * Atualiza um paciente
  */
  Future<void> updatePatient(Patient patient) async {
    if (patient == null || patient.id == null) {
      return;
    }
    InfoEndereco infoEndereco = InfoEndereco();
    infoEndereco.cep = patient.address.zipCode;
    infoEndereco.cidade = patient.address.city;
    infoEndereco.estado = patient.address.state;
    infoEndereco.logradouro = patient.address.street;
    infoEndereco.numero = patient.address.number;
    infoEndereco.id = patient.address.id;
    await _addressCtrl.atualizarEndereco(infoEndereco);
    InfoPaciente infoPaciente = InfoPaciente();
    infoPaciente.id = patient.id;
    infoPaciente.cpf = patient.cpf;
    infoPaciente.dataNascimento = patient.birthDate;
    infoPaciente.nome = patient.name;
    infoPaciente.telefone = patient.phoneNumber;
    await _patientCtrl.editarPaciente(infoPaciente);
    await loadPatients();
  }

  /*
  * Remove um paciente
  */
  Future<void> removePatient(Patient patient) async {
    if (patient == null) return;
    InfoPaciente infoPaciente = InfoPaciente();
    infoPaciente.id = patient.id;
    infoPaciente.refEndereco = patient.address.id;
    await _patientCtrl.excluirPaciente(infoPaciente);
    _items.remove(patient);
    notifyListeners();
  }
}
