import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/screens/medical_appointment/edit_appointment_screen.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final Appointment appointment;
  final Function callback;
  final Icon icon;
  PopupMenu({@required this.appointment, @required this.callback, this.icon});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: 30,
      icon: icon != null ? icon : Icon(Icons.more_horiz_rounded),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  settings: RouteSettings(arguments: appointment),
                  builder: (context) => EditAppointmentScreen(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.edit, color: Theme.of(context).accentColor),
                Text('Editar',
                    style: TextStyle(color: Theme.of(context).accentColor)),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await showDialog<Null>(
                context: context,
                builder: (ctx) => aletDialogRemove(
                  context: ctx,
                  message: 'Tem certeza que deseja excluir essa Consulta?',
                  callback: callback,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.delete, color: Theme.of(context).accentColor),
                Text('Excluir',
                    style: TextStyle(color: Theme.of(context).accentColor))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
