import 'package:flutter/foundation.dart';

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

  @override
  String toString() {
    return '{id: $id, patientId: $patientId, entryDate: $entryDate, note: $note}';
  }
}
