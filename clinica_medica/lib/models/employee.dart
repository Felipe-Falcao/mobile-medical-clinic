import 'package:clinica_medica/models/address.dart';
import 'package:flutter/cupertino.dart';

class Employee {
  String id;
  String workCard;
  DateTime hiringDate;
  String email;
  String name;
  String phoneNumber;
  String cpf;
  String password;
  Address address;

  Employee(
      {this.id,
      @required this.workCard,
      @required this.hiringDate,
      @required this.email,
      @required this.name,
      @required this.phoneNumber,
      @required this.cpf,
      @required this.password,
      @required this.address});

  Map toMap() {
    return {
      'Nome': name,
      'Telefone': phoneNumber,
      'E-mail': email,
      'Carteira de Trabalho': workCard,
      'Data de Contratação': hiringDate,
      'CPF': cpf,
    };
  }

  Employee.fromMap(Map json)
      : id = json['employeeId'] as String,
        workCard = json['workCard'] as String,
        hiringDate = json['hiringDate'] as DateTime,
        email = json['email'] as String,
        name = json['specialty'] as String,
        phoneNumber = json['phoneNumber'] as String,
        address = json['address'] as Address;
}
