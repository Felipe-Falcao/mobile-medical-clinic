import 'package:clinica_medica/controllers/consulta_controller.dart';
import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/consulta_data.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/schedule.dart';
import 'package:flutter/material.dart';

/*
 * Classe responsavel por fazer a comunicacao da camada View com a 
 * camada de Controle da aplicaçao em relaçao as funcionalidades de consultas.
 */
class Appointments with ChangeNotifier {
  final ConsultaController _appointmentCtrl = ConsultaController();
  List<Appointment> _items = [];

  /*
  * Retorna uma lista de todas as consultas cadastradas
  */
  List<Appointment> get items => [..._items];
  int get itemsCount => _items.length;

  /*
  * Retorna uma consulta dado o ID
  */
  Appointment getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  /*
  * Retorna uma lista de consulta cujos items contenha um filtro especificado.
  * Esse filtro pode ser parte do nome ou cpf do paciente.
  */
  List<Appointment> getItemsWith(String filter, List<Patient> patients) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items.where((appointment) {
      Patient patient =
          patients.singleWhere((el) => el.id == appointment.patientId);
      return patient.name.toLowerCase().contains(filter) ||
          patient.cpf.toLowerCase().contains(filter);
    }).toList();
  }

  /*
  * Retorna uma consulta dado um horario, um médico e uma data.
  * Ou 'null' se nao existir consulta para os paramentros dados.
  */
  Appointment getByTimeBlock(String timeBlock, String doctorId, DateTime date) {
    if (timeBlock == null || doctorId == null || date == null) return null;
    return _items.singleWhere((item) {
      return item.schedule.timeBlock == timeBlock &&
          item.doctorId == doctorId &&
          item.schedule.date == date;
    }, orElse: () => null);
  }

  /*
  * Carrega os dados atualizados das consultas cadastradas
  */
  Future<void> loadAppointments() async {
    List<Map<String, dynamic>> list = await _appointmentCtrl.buscarConsultas();
    _items.clear();
    for (var appointmentMap in list) {
      Map<String, dynamic> scheduleMap = await _appointmentCtrl
          .buscarAgendamento(appointmentMap['refAgendamento']);
      Schedule schedule = Schedule(
        id: appointmentMap['refAgendamento'],
        date: DateTime.fromMicrosecondsSinceEpoch(
            scheduleMap['data'].microsecondsSinceEpoch),
        timeBlock: scheduleMap['horario'],
      );
      Appointment appointment = Appointment(
        id: appointmentMap['id'],
        result: appointmentMap['resultado'],
        certificate: appointmentMap['atestado'],
        schedule: schedule,
        patientId: appointmentMap['refPaciente'],
        doctorId: appointmentMap['refMedico'],
      );
      _items.add(appointment);
    }
    notifyListeners();
  }

  /*
  * Cadastra uma nova consulta
  */
  Future<void> addAppointment(Appointment appointment) async {
    if (appointment == null) return;
    InfoConsulta infoConsulta = InfoConsulta();
    infoConsulta.data = appointment.schedule.date;
    infoConsulta.horario = appointment.schedule.timeBlock;
    infoConsulta.refMedico = appointment.doctorId;
    infoConsulta.refPaciente = appointment.patientId;
    await _appointmentCtrl.agendarConsulta(infoConsulta);
    await loadAppointments();
  }

  /*
  * Atualiza uma consulta
  */
  Future<void> updateAppointment(Appointment appointment) async {
    if (appointment == null || appointment.id == null) return;
    InfoConsulta infoConsulta = InfoConsulta();
    infoConsulta.id = appointment.id;
    infoConsulta.data = appointment.schedule.date;
    infoConsulta.horario = appointment.schedule.timeBlock;
    infoConsulta.refAgendamento = appointment.schedule.id;
    infoConsulta.atestado = appointment.certificate;
    infoConsulta.resultado = appointment.result;
    await _appointmentCtrl.editarConsulta(infoConsulta);
    await loadAppointments();
  }

  /*
  * Remove uma consulta
  */
  Future<void> removeAppointment(Appointment appointment) async {
    if (appointment == null) return;
    await _appointmentCtrl.excluirConsulta(
        appointment.id, appointment.schedule.id);
    _items.remove(appointment);
    notifyListeners();
  }

  /*
  * Remove todas as consultas que tenham referencia para um paciente ou medico,
  * dado o ID do medico ou paciente.
  */
  Future<void> removeAppointmentsWith(String id) async {
    for (Appointment appointment in _items) {
      if (appointment.patientId == id || appointment.doctorId == id) {
        await _appointmentCtrl.excluirConsulta(
            appointment.id, appointment.schedule.id);
      }
    }
    await loadAppointments();
  }
}
