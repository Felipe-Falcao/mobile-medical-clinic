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
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: GestureDetector(
                        onTap: _toggleHide,
                        child: Icon(
                          _hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[350],
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
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                    child: Text(_authData.isLogin
                        ? 'Quero me cadastrar!'
                        : 'Já possui uma conta?'),
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
