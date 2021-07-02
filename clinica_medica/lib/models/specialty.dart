import 'package:flutter/cupertino.dart';
import 'dart:core';

class Specialty {
  int id;
  String name;

  Specialty({this.id, @required name});

  static List<Specialty> getSpecialty() {
    return <Specialty>[
      Specialty(id: 1, name: 'Clinico Geral'),
      Specialty(id: 2, name: 'Ortopedista')
    ];
  }
}
