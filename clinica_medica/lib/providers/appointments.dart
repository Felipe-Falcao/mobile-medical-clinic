import 'dart:math';

import 'package:clinica_medica/models/appointment.dart';
import 'package:flutter/material.dart';

class Appointments with ChangeNotifier {
  List<Appointment> _items = [];

  List<Appointment> get items {
    return [..._items];
  }

  List<Appointment> getItemsWith(String filter) {
    if (filter == null) return [..._items];
    filter = filter.toLowerCase();
    return _items
        .where((appointment) =>
            appointment.patient.name.toLowerCase().contains(filter) ||
            appointment.patient.cpf.toLowerCase().contains(filter))
        .toList();
  }

  Appointment getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  void addAppointment(Appointment appointment) {
    _items.add(Appointment(
        id: Random().nextDouble().toString(),
        patient: appointment.patient,
        doctor: appointment.doctor,
        schedule: appointment.schedule,
        certificate: appointment.certificate,
        result: appointment.result));
    notifyListeners();
  }

  void updateAppointment(Appointment appointment) {
    if (appointment == null || appointment.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == appointment.id);
    if (index >= 0) {
      _items[index] = appointment;
      notifyListeners();
    }
  }

  void removeAppointment(Appointment appointment) {
    if (appointment == null) return;
    _items.remove(appointment);
    notifyListeners();
  }
}
