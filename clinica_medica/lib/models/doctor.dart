import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/specialty.dart';
import 'package:flutter/cupertino.dart';

class Doctor {
  String id;
  String crm;
  double salary;
  Employee employee;
  Specialty specialty;

  Doctor(
      {this.id,
      @required this.crm,
      @required this.salary,
      @required this.employee,
      @required this.specialty});

  Map toMap() {
    return {
      'id': id,
      'employee': employee,
      'crm': crm,
      'salary': salary,
      'specialty': specialty
    };
  }

  Doctor.fromMap(Map json)
      : id = json['id'] as String,
        employee = json['employee'] as Employee,
        crm = json['crm'] as String,
        salary = json['salary'] as double,
        specialty = json['specialty'] as Specialty;
}
