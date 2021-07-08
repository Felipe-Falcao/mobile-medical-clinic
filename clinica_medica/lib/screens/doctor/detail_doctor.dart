import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/screens/doctor/register_doctor_screen.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailDoctor extends StatefulWidget {
  const DetailDoctor({Key key}) : super(key: key);

  @override
  _DetailDoctorState createState() => _DetailDoctorState();
}

class _DetailDoctorState extends State<DetailDoctor> {
  Doctor doctor;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context).settings.arguments != null) {
      doctor = ModalRoute.of(context).settings.arguments as Doctor;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context);
    print(doctor.id);

    if (!isLoading) {
      setState(() {
        doctor = doctorProvider.getItemById(doctor.id);
      });
    }

    final appBar = AppBar(
      title: Text('Médico'),
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
                                  doctorProvider
                                      .removeDoctor(doctor)
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
                        itemCount: doctor.employee.toMap().length,
                        itemBuilder: (context, index) {
                          return _itemList(
                              doctor.employee.toMap().keys.toList()[index],
                              doctor.employee
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
                        itemCount: doctor.employee.address.toMap.length,
                        itemBuilder: (context, index) {
                          return _itemList(
                              doctor.employee.address.toMap.keys
                                  .toList()[index],
                              doctor.employee.address.toMap.values
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
                        'Especialidade',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                        itemCount: doctor.specialty.toMap().length,
                        itemBuilder: (context, index) {
                          return _itemList(
                              'Especialidade', doctor.specialty.name);
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
                        'Informações do Médico',
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
                        itemCount: doctor.toMap().length,
                        itemBuilder: (context, index) {
                          return _itemList(doctor.toMap().keys.toList()[index],
                              doctor.toMap().values.toList()[index].toString());
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
