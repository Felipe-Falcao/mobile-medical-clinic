import 'package:clinica_medica/models/auth_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  /*
   * Função responsável por cadastrar usuário.
   */
  Future<UserCredential> signUpFuncionario(infoFuncionario) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'SignupFunc', options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
              email: infoFuncionario.email.trim(),
              password: infoFuncionario.senha);
      await app.delete();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
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

  /*
   * Função responsável por retornar o usuário atual.
   */
  String getCurrentUser() {
    return _auth.currentUser.uid;
  }

  /*
   * Função responsável por atualizar senha do usuário.
   */
  Future<String> updatePassword(newPassword) async {
    User user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        return 'Atualizado com sucesso!';
      } catch (err) {
        print(err);
        return 'Houve um erro ao atualizar a senha!';
      }
    }
  }
}
