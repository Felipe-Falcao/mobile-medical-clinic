import 'dart:math';

import 'package:clinica_medica/data/doctor_data.dart';
import 'package:clinica_medica/models/doctor.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> _items = DOCTOR_DATA;

  List<Doctor> get items {
    return [..._items];
  }

  List<Doctor> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();

    return _items
        .where((doctor) =>
            doctor.employee.name.toLowerCase().contains(filter) ||
            doctor.specialty.name.contains(filter))
        .toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void addDoctor(Doctor doctor) {
    _items.add(Doctor(
        id: Random().nextDouble().toString(),
        crm: doctor.crm,
        salary: doctor.salary,
        employee: doctor.employee,
        specialty: doctor.specialty));

    notifyListeners();
  }

  void updateDoctor(Doctor doctor) {
    if (doctor == null || doctor.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == doctor.id);
    if (index >= 0) {
      _items[index] = doctor;
      notifyListeners();
    }
  }
}
