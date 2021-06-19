import 'package:flutter/foundation.dart';

class Address {
  final String street;
  final String number;
  final String zipCode;
  final String city;
  final String state;

  Address({
    @required this.street,
    @required this.number,
    @required this.zipCode,
    @required this.city,
    @required this.state,
  });

  List<String> keys() {
    return ['Rua', 'Número', 'CEP', 'Cidade', 'Estado'];
  }

  List<String> values() {
    return [
      street,
      number,
      zipCode,
      city,
      state,
    ];
  }

  @override
  String toString() {
    return '{street: $street, number: $number, zipCode: $zipCode, city: $city, state: $state}';
  }
}
