import 'package:clinica_medica/models/patient.dart';
import 'package:flutter/foundation.dart';

class Chart {
  String id;
  Patient patient;
  DateTime entryDate;
  String note;

  Chart(
      {this.id,
      @required this.patient,
      @required this.entryDate,
      @required this.note});

  @override
  String toString() {
    return '{id: $id, patientId: $patient, entryDate: $entryDate, note: $note}';
  }
}
