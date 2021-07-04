import 'package:flutter/cupertino.dart';
import 'dart:core';

class Specialty {
  int id;
  String name;

  Specialty({this.id, @required this.name});

  Map toMap() {
    return {
      'Especialidade': name,
    };
  }
}
