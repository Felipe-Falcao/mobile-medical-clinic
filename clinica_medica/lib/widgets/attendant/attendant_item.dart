import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/screens/attendant/detail_attendant_screen.dart';
import 'package:clinica_medica/widgets/attendant/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendantItem extends StatelessWidget {
  final Attendant attendant;
  const AttendantItem({@required this.attendant});

  @override
  Widget build(BuildContext context) {
    AttendantProvider attendantProvider = Provider.of(context);

    return Card(
      child: ListTile(
          title: Text(attendant.employee.name),
          subtitle: Text(attendant.employee.cpf),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailAttendantScreen(),
                settings: RouteSettings(arguments: attendant)));
          },
          leading: CircleAvatar(
            child: Text(
              '${attendant.employee.name[0]}',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          trailing: PopupMenu(
            attendant: attendant,
            callback: (bool value) {
              if (value) {
                attendantProvider.removeAttendant(attendant);
              }
            },
          )),
    );
  }
}
