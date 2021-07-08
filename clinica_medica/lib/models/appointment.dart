import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/schedule.dart';
import 'package:flutter/foundation.dart';

class Appointment {
  final String id;
  final String certificate;
  final String result;
  final Schedule schedule;
  final Patient patient;
  final Doctor doctor;

  Appointment(
      {this.id,
      this.certificate,
      this.result,
      @required this.schedule,
      @required this.patient,
      @required this.doctor});
}

class Doctor {
  final String id;
  final String name;
  final String CRM;
  double salary;

  Doctor({this.id, this.name, this.CRM, this.salary});
}
