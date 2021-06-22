import 'dart:math';

import 'package:clinica_medica/data/dummy_data.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:flutter/material.dart';

class Patients with ChangeNotifier {
  List<Patient> _items = DUMMY_PATIENTS;

  List<Patient> get items {
    return [..._items];
  }

  List<Patient> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items
        .where((patient) =>
            patient.name.toLowerCase().contains(filter) ||
            patient.cpf.toLowerCase().contains(filter))
        .toList();
  }

  Patient getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  void addPatient(Patient patient) {
    _items.add(Patient(
      id: Random().nextDouble().toString(),
      name: patient.name,
      phoneNumber: patient.phoneNumber,
      cpf: patient.cpf,
      birthDate: patient.birthDate,
      address: patient.address,
    ));
    notifyListeners();
  }

  void updatePatient(Patient patient) {
    if (patient == null || patient.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == patient.id);
    if (index >= 0) {
      _items[index] = patient;
      notifyListeners();
    }
  }

  void removePatient(Patient patient) {
    if (patient == null) return;
    _items.remove(patient);
    notifyListeners();
  }
}
