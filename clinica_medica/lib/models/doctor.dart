import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/specialty.dart';
import 'package:flutter/cupertino.dart';

class Doctor {
  String id;
  String crm;
  double salary;
  Employee employee;
  Specialty specialty;
  String type = 'medico';

  Doctor(
      {this.id,
      @required this.crm,
      @required this.salary,
      @required this.employee,
      @required this.specialty});

  Map toMap() {
    return {
      'CRM': crm,
      'Salário': salary,
    };
  }

  Doctor.fromMap(Map json)
      : id = json['id'] as String,
        crm = json['crm'] as String,
        salary = json['salary'] as double;

  @override
  String toString() {
    return '{id: $id, crm: $crm, salario: $salary, especialidade: $specialty, funcionario: $employee}';
  }
}
