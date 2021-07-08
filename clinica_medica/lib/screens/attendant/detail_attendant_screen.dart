import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/screens/attendant/register_attendant_screen.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAttendantScreen extends StatefulWidget {
  const DetailAttendantScreen({Key key}) : super(key: key);

  @override
  _DetailAttendantScreenState createState() => _DetailAttendantScreenState();
}

class _DetailAttendantScreenState extends State<DetailAttendantScreen> {
  Attendant attendant;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context).settings.arguments != null) {
      attendant = ModalRoute.of(context).settings.arguments as Attendant;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AttendantProvider attendantProvider =
        Provider.of<AttendantProvider>(context);

    if (!isLoading) {
      setState(() {
        attendant = attendantProvider.getItemById(attendant.id);
      });
    }

    final appBar = AppBar(
      title: Text('Atendente'),
      actions: [
        PopupMenuButton(
          iconSize: 30,
          child: Icon(Icons.more_vert_rounded),
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
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
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
                                  'Tem certeza que deseja excluir esse paciente',
                              callback: (bool value) {
                                if (value) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  attendantProvider
                                      .removeAttendant(attendant)
                                      .then((_) => Navigator.of(context).pop());
                                }
                              }));
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
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        )
                      ],
                    )),
                value: 'excluir',
              ),
            ];
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Informações Pessoais',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Container(
                    height: 170,
                    child: ListView.builder(
                        itemCount: attendant.employee.toMap().length,
                        itemBuilder: (context, index) {
                          return _itemList(
                              attendant.employee.toMap().keys.toList()[index],
                              attendant.employee
                                  .toMap()
                                  .values
                                  .toList()[index]
                                  .toString());
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Endereço',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Container(
                    height: 170,
                    child: ListView.builder(
                        itemCount: attendant.employee.address.toMap.length,
                        itemBuilder: (context, index) {
                          return _itemList(
                              attendant.employee.address.toMap.keys
                                  .toList()[index],
                              attendant.employee.address.toMap.values
                                  .toList()[index]
                                  .toString());
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Informações do Atendente',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Container(
                    height: 130,
                    child: ListView.builder(
                        itemCount: attendant.toMap().length,
                        itemBuilder: (context, index) {
                          return _itemList(
                              attendant.toMap().keys.toList()[index],
                              attendant
                                  .toMap()
                                  .values
                                  .toList()[index]
                                  .toString());
                        }),
                  )
                ],
              )),
    );
  }

  Widget _itemList(String key, String value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              key,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Container(
            width: 150,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                value,
                overflow: TextOverflow.fade,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
