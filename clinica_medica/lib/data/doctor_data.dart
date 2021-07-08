import 'dart:math';

import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/specialty.dart';

final address = Address(
    street: 'Rua laranjeiras',
    number: '120',
    zipCode: '49130000',
    city: 'Aracaju',
    state: 'Sergipe');

final specialty = Specialty(name: 'Ortopedista');

final employee = Employee(
    workCard: '22222222222222',
    hiringDate: DateTime(2021, 06, 16),
    email: 'joao_emanual@hotmail.com',
    name: 'Joao Emanuel',
    phoneNumber: '9999999999',
    cpf: '20053297032',
    password: '12Tt@#1d',
    address: address);

final DOCTOR_DATA = [
  Doctor(
      id: Random().nextDouble().toString(),
      crm: '00000000000',
      salary: 10000,
      employee: employee,
      specialty: specialty)
];
