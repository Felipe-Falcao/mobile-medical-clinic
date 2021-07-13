import 'package:clinica_medica/controllers/funcionario_controller.dart';
import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:flutter/material.dart';

/*
 * Classe responsavel por fazer a comunicacao da camada View com a 
 * camada de Controle da aplicaçao em relaçao as funcionalidades de usuario.
 */
class UserProvider with ChangeNotifier {
  final AuthenticationFB _auth = AuthenticationFB();
  final FuncionarioController _emplCtrl = FuncionarioController();
  User _user;

  /*
  * Retorna informacoes basicas do usuario logado
  */
  User get user => _user;
  bool get isAdmin => _user?.type == Type.ADMIN;
  bool get isDoctor => _user?.type == Type.DOCTOR;
  bool get isAttendant => _user?.type == Type.ATTENDANT;
  String get firstName => _user?.name?.split(' ')[0];

  /*
  * Carrega os dados atualizado do usuario logado
  */
  Future<void> loadUser() async {
    String userId = _auth.getCurrentUser();
    if (userId == null) return;
    Map<String, dynamic> empl = await _emplCtrl.buscarFuncionario(userId);
    User user = User(
      id: empl['id'],
      type: empl['tipoFuncionario'],
      name: empl['nome'],
      cpf: empl['cpf'],
      email: empl['email'],
      phoneNumber: empl['telefone'],
    );
    _user = user;
    notifyListeners();
  }
}

/*
 * Define os tipos de usuario
 */
class Type {
  static const ADMIN = 'admin';
  static const DOCTOR = 'medico';
  static const ATTENDANT = 'atendente';
}

/*
 * Modelo de um usuario
 */
class User {
  final String id;
  final String name;
  final String email;
  final String cpf;
  final String phoneNumber;
  final String type;

  User({
    @required this.id,
    @required this.type,
    this.name,
    this.email,
    this.cpf,
    this.phoneNumber,
  });
}
