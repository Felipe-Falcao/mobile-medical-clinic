import 'package:brasil_fields/brasil_fields.dart';
import 'package:clinic_app_01/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _cpf = TextEditingController();
  TextEditingController _senha = TextEditingController();

  validarSenha() {
    if (_senha.text.length < 16 && _senha.text.length > 8) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 1, bottom: 150, left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo01.png', width: 110, height: 90),
              Padding(padding: EdgeInsets.only(bottom: 50)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //new Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                ],
              ),

              TextFormField(
                  key: _formKey,
                  controller: _cpf,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  decoration: new InputDecoration(
                    fillColor: Color(0xffE4E5E7),
                    filled: true,
                    border: new OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8.0)),
                        borderSide: new BorderSide(
                            color: Colors.transparent, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    labelText: 'Usuário',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  )),

              Padding(padding: EdgeInsets.only(top: 2.0, bottom: 15.0)),

              TextFormField(
                  obscureText: true,
                  controller: _senha,
                  decoration: new InputDecoration(
                    fillColor: Color(0xffE4E5E7),
                    filled: true,
                    border: new OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8.0)),
                        borderSide: new BorderSide(
                            color: Colors.transparent, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  )),

              Padding(padding: EdgeInsets.only(top: 2.0, bottom: 15.0)),

              // ignore: deprecated_member_use
              FlatButton(
                height: 45,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                onPressed: () {
                  String cpf = _cpf.text;

                  if (GetUtils.isCpf(cpf) && validarSenha()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  } else {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 180,
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(bottom: 70)),
                                  const Text(
                                    'Usuário ou senha inválida',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 16.0),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 50)),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 10,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xff72D5C0))),
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
                color: Color(0xff72D5C0),
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 2.0, bottom: 15.0)),
              Center(
                child: Text('Esqueceu sua senha? Clique aqui e recupere'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
