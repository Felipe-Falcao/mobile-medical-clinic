import 'package:clinica_medica/models/schedule.dart';
import 'package:flutter/material.dart';

class Schedules with ChangeNotifier {
  List<Schedule> _items = [];

  List<Schedule> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Schedule getItemById(String id) {
    return _items.singleWhere((item) => item.id == id);
  }

  List<String> get timeBlocks => [
        'H8M00',
        'H8M30',
        'H9M00',
        'H9M30',
        'H10M00',
        'H10M30',
        'H11M00',
        'H11M30',
        'H12M00',
        'H12M30',
        'H13M00',
        'H13M30',
        'H14M00',
        'H14M30',
        'H15M00',
        'H15M30',
        'H16M00',
        'H16M30',
        'H17M00',
        'H17M30'
      ];

  // List<Schedule> getItemsWith(String filter) {
  //   if (filter == null) return [..._items];
  //   filter = filter.toLowerCase();
  //   return _items
  //       .where((Schedule) =>
  //           schedule.patient.name.toLowerCase().contains(filter) ||
  //           schedule.patient.cpf.toLowerCase().contains(filter))
  //       .toList();
  // }
}
