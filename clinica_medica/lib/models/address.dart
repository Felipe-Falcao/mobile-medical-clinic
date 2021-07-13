import 'package:flutter/foundation.dart';

/*
 * Modelo de endereço para pacientes, médicos e atendentes.
 */
class Address {
  final String id;
  final String street;
  final String number;
  final String zipCode;
  final String city;
  final String state;

  Address({
    this.id,
    @required this.street,
    @required this.number,
    @required this.zipCode,
    @required this.city,
    @required this.state,
  });

  Map<String, String> get toMap {
    return {
      'Rua': street,
      'Número': number,
      'CEP': zipCode,
      'Cidade': city,
      'Estado': state
    };
  }

  @override
  String toString() {
    return '{street: $street, number: $number, zipCode: $zipCode, city: $city, state: $state}';
  }
}
