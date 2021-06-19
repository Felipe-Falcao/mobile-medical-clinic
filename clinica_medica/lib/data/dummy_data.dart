import 'dart:math';

import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/patient.dart';

final address = Address(
  street: 'Rua A',
  number: '850',
  zipCode: '49000-000',
  city: 'Aracaju',
  state: 'Sergipe',
);

final DUMMY_PATIENTS = [
  Patient(
    id: Random().nextDouble().toString(),
    name: 'Beatriz Santos',
    cpf: '555.000.222-00',
    phoneNumber: '(79)99999-1111',
    birthDate: new DateTime(2000, 5, 5),
    address: address,
  ),
  Patient(
    id: Random().nextDouble().toString(),
    name: 'Ana Paula',
    cpf: '111.000.222-00',
    phoneNumber: '(79)99999-3333',
    birthDate: new DateTime(1995, 5, 5),
    address: address,
  ),
  Patient(
    id: Random().nextDouble().toString(),
    name: 'Fabio Silva',
    cpf: '222.000.222-00',
    phoneNumber: '(79)99999-8888',
    birthDate: new DateTime(2002, 5, 5),
    address: address,
  ),
  Patient(
    id: Random().nextDouble().toString(),
    name: 'Carlos Pereira',
    cpf: '444.000.222-00',
    phoneNumber: '(79)99999-5555',
    birthDate: new DateTime(1997, 5, 5),
    address: address,
  ),
];
