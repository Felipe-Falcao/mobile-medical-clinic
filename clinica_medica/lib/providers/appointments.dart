import 'package:clinica_medica/controllers/consulta_controller.dart';
import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/consulta_data.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/schedule.dart';
import 'package:flutter/material.dart';

class Appointments with ChangeNotifier {
  final ConsultaController _appointmentCtrl = ConsultaController();
  List<Appointment> _items = [];

  List<Appointment> get items => [..._items];
  int get itemsCount => _items.length;

  Appointment getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

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

  Appointment getByTimeBlock(String timeBlock, String doctorId, DateTime date) {
    if (timeBlock == null || doctorId == null || date == null) return null;
    return _items.singleWhere((item) {
      return item.schedule.timeBlock == timeBlock &&
          item.doctorId == doctorId &&
          item.schedule.date == date;
    }, orElse: () => null);
  }

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

  Future<void> removeAppointment(Appointment appointment) async {
    if (appointment == null) return;
    await _appointmentCtrl.excluirConsulta(
        appointment.id, appointment.schedule.id);
    _items.remove(appointment);
    notifyListeners();
  }

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
