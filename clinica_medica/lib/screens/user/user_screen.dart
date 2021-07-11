import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/new_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AuthenticationFB auth = AuthenticationFB();
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = Map<String, Object>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProv = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
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
                          Icon(
                            Icons.vpn_key,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      onPressed: _popupForm,
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
          Container(
            width: size.width,
            height: size.height * .6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        ],
      ),
    );
  }

  _logout() => auth
      .signOut()
      .then((value) => Navigator.of(context).pushReplacementNamed('/'));

  _popupForm() {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: -27.0,
                top: -27.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.close),
                    backgroundColor: Colors.black87,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: NewTextFormField(
                        formData: _formData,
                        labelText: 'Nova Senha',
                        keyFormData: 'password',
                        isObscure: true,
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = value.trim().length < 7;
                          if (isEmpty || isInvalid) {
                            return 'Informe uma senha válida com no mínimo 7 caracteres!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: NewTextFormField(
                        formData: _formData,
                        labelText: 'Confirme a senha',
                        keyFormData: 'check',
                        isObscure: true,
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = value.trim().length < 7;
                          if (value != _formData['password']) {
                            return 'As senhas informadas não conferem';
                          }
                          if (isEmpty || isInvalid) {
                            return 'Informe uma senha válida com no mínimo 7 caracteres!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.black87),
                        ),
                        onPressed: _saveForm,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    try {
      await auth.updatePassword(_formData['password']);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => aletDialogSuccess(
          context: ctx,
          message: 'Senha alterada com sucesso.',
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro ao salvar a Senha!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
