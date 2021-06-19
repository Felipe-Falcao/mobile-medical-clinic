import 'package:flutter/material.dart';

AlertDialog aletDialogSuccess({
  @required BuildContext context,
  @required String message,
}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    titlePadding: EdgeInsets.all(30),
    title: Column(
      children: [
        Icon(Icons.check_circle_outline_outlined,
            size: 50, color: Theme.of(context).primaryColor),
        Text('Sucesso!'),
        Divider(),
        Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54))
      ],
    ),
    actionsPadding: EdgeInsets.only(bottom: 10),
    actions: <Widget>[
      Center(
        child: Container(
          height: 35,
          width: 70,
          child: TextButton(
            child: Text('Ok',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 17)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    ],
  );
}

AlertDialog aletDialogRemove(
    {@required BuildContext context,
    @required String message,
    @required Function callback}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    // titlePadding: EdgeInsets.all(30),
    title: Column(
      children: [
        Icon(Icons.warning, size: 50, color: Colors.red[700]),
        Text('Cuidado!'),
        Divider(),
        Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54))
      ],
    ),
    actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
    actions: <Widget>[
      Container(
        height: 35,
        width: 90,
        child: TextButton(
            child: Text('CANCELAR',
                style: TextStyle(color: Theme.of(context).accentColor)),
            onPressed: () {
              callback(false);
              Navigator.of(context).pop();
            }),
      ),
      Container(
        height: 35,
        width: 100,
        child: TextButton(
            child: Text('EXCLUIR',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.of(context).pop();
              callback(true);
            }),
      ),
    ],
  );
}
