import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/screens/doctor/register_doctor_screen.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final Doctor doctor;
  final Function callback;
  final Icon icon;

  const PopupMenu({@required this.doctor, @required this.callback, this.icon});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: 30,
      child: Icon(Icons.more_horiz),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      settings: RouteSettings(arguments: doctor),
                      builder: (context) => RegisterDoctor()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(
                      'Editar',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    )
                  ],
                )),
            value: 'editar',
          ),
          PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await showDialog<Null>(
                      context: context,
                      builder: (context) => aletDialogRemove(
                          context: context,
                          message:
                              'Tem certeza que deseja excluir esse médico?',
                          callback: callback));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(
                      'Excluir',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    )
                  ],
                )),
            value: 'excluir',
          ),
        ];
      },
    );
  }
}
