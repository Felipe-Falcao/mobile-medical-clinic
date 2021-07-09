import 'package:flutter/foundation.dart';

class Receita {
  String id;
  DateTime dataPrescricao;
  String dose;
  String nome;
  String refMedico;
  String refPaciente;

  Receita({
    this.id,
    @required this.refPaciente,
    @required this.refMedico,
    @required this.dataPrescricao,
    this.nome,
    this.dose,
  });
}
