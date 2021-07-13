import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'address.dart';

/*
 * Classe modelo para paciente.
 */
class Patient {
  final String id;
  final String name;
  final String phoneNumber;
  final String cpf;
  final DateTime birthDate;
  final Address address;

  Patient({
    this.id,
    @required this.name,
    @required this.phoneNumber,
    @required this.cpf,
    @required this.birthDate,
    @required this.address,
  });

  Map<String, String> get toMap {
    return {
      'Nome': name,
      'Telefone': phoneNumber,
      'CPF': cpf,
      'Data de Nascimento': new DateFormat('dd/MM/yyyy').format(birthDate),
    };
  }

  @override
  String toString() {
    return '{id: $id, name: $name, phoneNumber: $phoneNumber, cpf: $cpf, birthDate: $birthDate, address: $address}';
  }
}
