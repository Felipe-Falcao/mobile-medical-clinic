import 'package:clinica_medica/models/auth_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFB {
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;

  /*
   * Função responsável por fazer login do usuário.
   */
  Future<UserCredential> signIn(AuthData authData) async {
    userCredential = await _auth.signInWithEmailAndPassword(
      email: authData.email.trim(),
      password: authData.password,
    );
    return userCredential;
  }

  /*
   * Função responsável por cadastrar usuário.
   */
  Future<UserCredential> signUp(AuthData authData) async {
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: authData.email.trim(),
      password: authData.password,
    );
    return userCredential;
  }

  Future<UserCredential> signUpFuncionario(infoFuncionario) async {
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: infoFuncionario.email.trim(),
      password: infoFuncionario.senha,
    );
    return userCredential;
  }

  /*
   * Função responsável por deslogar usuário.
   */
  Future<void> signOut() async {
    _auth.signOut();
  }

  /*
   * Função responsável por verificar se usuário está logado.
   */
  Stream<User> isLogged() {
    return _auth.authStateChanges();
  }

  String getCurrentUser() {
    return _auth.currentUser.uid;
  }
}
