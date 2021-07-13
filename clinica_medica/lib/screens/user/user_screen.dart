import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/new_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
* Responsavel por renderizar a tela de usuário
*/
class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AuthenticationFB auth = AuthenticationFB();
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = Map<String, Object>();
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProv = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * .37,
              width: size.width,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  AppBar(
                    elevation: 0,
                    actions: [
                      TextButton(
                        child: Row(
                          children: [
                            Text(
                              'Alterar Senha',
                              style: TextStyle(color: Colors.black87),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.vpn_key, color: Colors.black54),
                            SizedBox(width: 10),
                          ],
                        ),
                        onPressed: () => setState(() => _editing = true),
                      )
                    ],
                  ),
                  Icon(Icons.account_circle_rounded, size: 100),
                  const SizedBox(height: 10),
                  Text(
                    '${userProv.user.name}',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            Visibility(
              visible: !_editing,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height * .6,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('${userProv.user.email}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.perm_identity),
                          title: Text('${userProv.user.cpf}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('${userProv.user.phoneNumber}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.lock_open),
                          title: Text('${userProv.user.type}'),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: _logout,
                          child: Text('Sair'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _editing,
              child: _form(),
            ),
          ],
        ),
      ),
    );
  }

  _logout() => auth
      .signOut()
      .then((value) => Navigator.of(context).pushReplacementNamed('/'));

  _form() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            NewTextFormField(
              formData: _formData,
              labelText: 'Nova Senha',
              keyFormData: 'password',
              isObscure: true,
              validator: (value) {
                bool isEmpty = value.trim().isEmpty;
                bool isInvalid = value.trim().length < 7;
                if (isEmpty || isInvalid) {
                  return 'Informe uma senha com no mínimo 7 caracteres!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            NewTextFormField(
              formData: _formData,
              labelText: 'Confirme a Senha',
              keyFormData: 'check',
              isObscure: true,
              validator: (value) {
                bool isEmpty = value.trim().isEmpty;
                bool isInvalid = value.trim().length < 7;
                if (isEmpty || isInvalid) {
                  return 'Informe uma senha com no mínimo 7 caracteres!';
                }
                if (value != _formData['password']) {
                  return 'As senhas informadas não conferem';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                cancelButton(
                    context,
                    () => setState(() {
                          _formData['password'] = null;
                          _formData['check'] = null;
                          _editing = false;
                        })),
                Spacer(),
                finishButton(context, _saveForm),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    try {
      await auth.updatePassword(_formData['password']);
      setState(() {
        _formData['password'] = null;
        _formData['check'] = null;
        _editing = false;
      });
      await showDialog<Null>(
        context: context,
        builder: (ctx) => aletDialogSuccess(
          context: ctx,
          message: 'Senha alterada com sucesso.',
        ),
      );
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro ao salvar a Senha!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                setState(() => _editing = false);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
