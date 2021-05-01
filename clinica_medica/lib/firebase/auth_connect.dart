import 'package:clinica_medica/models/auth_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFB {
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;

  /*
   * Função responsável por fazer login do usuário.
   */
  Future<UserCredential> signin(AuthData authData) async {
    userCredential = await _auth.signInWithEmailAndPassword(
      email: authData.email.trim(),
      password: authData.password,
    );
    return userCredential;
  }

  /*
   * Função responsável por cadastrar usuário.
   */
  Future<UserCredential> signup(AuthData authData) async {
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: authData.email.trim(),
      password: authData.password,
    );
    return userCredential;
  }

  /*
   * Função responsável por deslogar usuário.
   */
  Future<void> signout() async {
    _auth.signOut();
  }

  /*
   * Função responsável por verificar se usuário está logado.
   */
  Stream<User> isLogged() {
    return _auth.authStateChanges();
  }
}
