import 'dart:math';

import 'package:clinica_medica/models/chart.dart';
import 'package:flutter/material.dart';

class Charts with ChangeNotifier {
  List<Chart> _items = [];

  List<Chart> get items {
    return [..._items];
  }

  // List<Patient> getItemsWith(String filter) {
  //   if (filter == null) return [..._items];
  //   filter = filter.toLowerCase();
  //   return _items
  //       .where((patient) =>
  //           patient.name.toLowerCase().contains(filter) ||
  //           patient.cpf.toLowerCase().contains(filter))
  //       .toList();
  // }

  Chart getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  int get itemsCount {
    return _items.length;
  }

  void addChart(Chart chart) {
    _items.add(Chart(
      id: Random().nextDouble().toString(),
      patientId: chart.patientId,
      entryDate: chart.entryDate,
      note: chart.note,
    ));
    notifyListeners();
  }

  void updateChart(Chart chart) {
    if (chart == null || chart.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == chart.id);
    if (index >= 0) {
      _items[index] = chart;
      notifyListeners();
    }
  }

  void removeChart(Chart chart) {
    if (chart == null) return;
    _items.remove(chart);
    notifyListeners();
  }
}
