import 'package:clinica_medica/models/employee.dart';
import 'package:flutter/material.dart';

class Attendant {
  String id;
  Employee employee;
  double salary;
  String rotation;
  String type = 'atendente';

  Attendant(
      {this.id,
      @required this.employee,
      @required this.salary,
      @required this.rotation});

  Map toMap() {
    return {'Salário': salary, 'Turno': rotation};
  }

  Attendant.fromMap(Map json)
      : id = json['id'] as String,
        salary = json['salary'] as double,
        rotation = json['rotation'] as String;

  @override
  String toString() {
    return '{id: $id, salario: $salary, turno: $rotation, funcionario: $employee}';
  }
}
