import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Chart {
  String id;
  String patientId;
  DateTime entryDate;
  String note;

  Chart(
      {this.id,
      @required this.patientId,
      @required this.entryDate,
      @required this.note});

  List<String> keys() {
    return ['ID do paciente', 'Data de cadastro', 'Nota'];
  }

  List<String> values() {
    return [
      patientId,
      new DateFormat('dd/MM/yyyy').format(entryDate),
      note,
    ];
  }

  @override
  String toString() {
    return '{id: $id, patientId: $patientId, entryDate: $entryDate, note: $note}';
  }
}
