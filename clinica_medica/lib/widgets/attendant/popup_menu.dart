import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/screens/attendant/register_attendant_screen.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:flutter/material.dart';

//Classe que cria o componente popups que apresenta as opções de editar
//e excluir na lista de atendentes
class PopupMenu extends StatelessWidget {
  final Attendant attendant;
  final Function callback;
  final Icon icon;

  const PopupMenu(
      {@required this.attendant, @required this.callback, this.icon});

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
                      settings: RouteSettings(arguments: attendant),
                      builder: (context) => RegisterAttendantScreen()));
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
                              'Tem certeza que deseja excluir esse atendente?',
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
