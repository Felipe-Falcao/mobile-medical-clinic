import 'package:clinica_medica/screens/doctor/register_doctor_screen.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color = Theme.of(context).accentColor;

    Container _itemMenu(String nomeItem) => Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Card(
          color: Color(0xFFD8E6F0),
          child: ListTile(
            title: Text(
              nomeItem,
              style: TextStyle(color: _color),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _color,
            ),
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Médico'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
        children: [
          InkWell(
            child: _itemMenu('Cadastrar Médico'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterDoctor()));
            },
          ),
        ],
      ),
    );
  }
}
