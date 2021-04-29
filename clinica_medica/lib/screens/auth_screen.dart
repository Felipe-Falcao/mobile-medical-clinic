import 'package:clinica_medica/models/auth_data.dart';
import 'package:clinica_medica/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential userCredential;

    try {
      if (authData.isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );

        final userData = {
          'nome': authData.name,
          'carteiraTrabalho': '123456',
          'dataContratacao': DateTime.now(),
          'email': authData.email,
          'refEndereco': 'endereco/null',
          'refEspecialidade': 'endereco/null',
          'telefone': '79 99999999'
        };

        await FirebaseFirestore.instance
            .collection('funcionario')
            .doc(userCredential.user.uid)
            .set(userData);
      }
    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        },
      );
    } catch (err) {
      final msg = err.message;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // body: AuthForm(_handleSubmit),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AuthForm(_handleSubmit),
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
