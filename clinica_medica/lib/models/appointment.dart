import 'package:clinica_medica/models/schedule.dart';
import 'package:flutter/foundation.dart';

/*
 * Classe modelo para um agendamento.
 */
class Appointment {
  final String id;
  final String certificate;
  final String result;
  final Schedule schedule;
  final String patientId;
  final String doctorId;

  Appointment(
      {this.id,
      this.certificate,
      this.result,
      @required this.schedule,
      @required this.patientId,
      @required this.doctorId});
}

// class Doctor {
//   final String id;
//   final String name;
//   final String CRM;
//   double salary;

//   Doctor({this.id, this.name, this.CRM, this.salary});
// }
