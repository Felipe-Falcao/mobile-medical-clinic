import 'package:clinica_medica/models/auth_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();
  bool _hidePassword = true;

  _toggleHide() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget.onSubmit(_authData);
      // print(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 0.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      initialValue: _authData.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no minimo 4 caracteres.';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: new InputDecoration(
                      fillColor: Color(0xffE4E5E7),
                      filled: true,
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0)),
                          borderSide: new BorderSide(
                              color: Colors.transparent, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.transparent)),
                      labelText: 'Usuário',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido.';
                      }
                      return null;
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 2.0, bottom: 15.0)),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: _hidePassword,
                    decoration: new InputDecoration(
                      fillColor: Color(0xffE4E5E7),
                      filled: true,
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0)),
                          borderSide: new BorderSide(
                              color: Colors.transparent, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.transparent)),
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: GestureDetector(
                        onTap: _toggleHide,
                        child: Icon(
                          _hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no minimo 7 caracteres.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: double.infinity),
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: Text(
                        _authData.isLogin ? 'Entrar' : 'Cadastrar',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.grey;
                            return Color(0xff72D5C0);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
