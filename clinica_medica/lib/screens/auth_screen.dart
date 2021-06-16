import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/infra/funcionario_connect.dart';
import 'package:clinica_medica/models/auth_data.dart';
import 'package:clinica_medica/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clinica_medica/controllers/funcionario_controller.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthenticationFB auth = new AuthenticationFB();
  FuncionarioFB funcionarioFB = new FuncionarioFB();

  FuncionarioController funcionarioController = new FuncionarioController();

  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential userCredential;

    try {
      if (authData.isLogin) {
        userCredential = await auth.signIn(authData);
      } else {
        userCredential = await auth.signUp(authData);
        // await funcionarioFB.create(authData, userCredential, 'null', 'null');
        await funcionarioController.createfuncMedico(
            authData,
            userCredential,
            '4900000',
            'Aracaju',
            'SE',
            'logradouro',
            '12',
            'Ortopedista',
            12000,
            '1111');
        // await funcionarioController.createFuncAtendente(
        //     authData,
        //     userCredential,
        //     999,
        //     'manhã',
        //     '49999',
        //     'Aracaju',
        //     'SE',
        //     'Rua X',
        //     '12');
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
