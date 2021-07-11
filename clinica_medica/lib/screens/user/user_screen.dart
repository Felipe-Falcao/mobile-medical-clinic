import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AuthenticationFB auth = AuthenticationFB();

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
                  actions: [_button()],
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
            color: Colors.teal[50],
            child: Column(
              children: [
                SizedBox(height: 10),
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
                  onPressed: () {
                    auth.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AuthScreen()),
                    );
                  },
                  child: Text('Sair'),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _button() {
    return DropdownButton(
      underline: SizedBox(),
      icon: Icon(
        Icons.more_vert,
        size: 30,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      items: [
        DropdownMenuItem(
          value: 'password',
          child: Container(
            child: Row(
              children: [
                Icon(Icons.vpn_key, color: Colors.black),
                SizedBox(width: 8),
                Text('Alterar senha'),
              ],
            ),
          ),
        )
      ],
      onChanged: (item) {
        if (item == 'password') {
          //
        }
      },
    );
  }
}
