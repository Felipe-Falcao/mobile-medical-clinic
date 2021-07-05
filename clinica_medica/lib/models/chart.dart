import 'package:flutter/foundation.dart';

class Chart {
  String id;
  String patientId;
  DateTime entryDate;
  DateTime updateDate;
  String medicineId;
  String note;

  Chart({
    this.id,
    @required this.patientId,
    this.entryDate,
    this.updateDate,
    this.medicineId,
    @required this.note,
  });
}
