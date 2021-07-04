import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/screens/doctor/detail_doctor.dart';
import 'package:clinica_medica/screens/doctor/register_doctor_screen.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindDoctor extends StatefulWidget {
  const FindDoctor({Key key}) : super(key: key);

  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  final _formData = Map<String, Object>();
  String _filter;

  @override
  Widget build(BuildContext context) {
    _filter = _formData['filter'] != null ? _formData['filter'] : null;
    final DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context);
    final List<Doctor> doctors = doctorProvider.getItemsWith(_filter);

    final appBar = AppBar(
      title: Text('Buscar Funcionário'),
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 90,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Icon(Icons.search_rounded),
                        right: 14,
                        top: 14,
                      ),
                      CustomTextFormField(
                        keyFormData: 'filter',
                        formData: _formData,
                        labelText: 'Digite o nome ou a especialidade',
                        onChanged: (value) {
                          setState(() {
                            _filter = value;
                          });
                        },
                      )
                    ],
                  )),
            ),
            Container(
                height: availableHeight - 90,
                child: ListView.builder(
                    itemBuilder: (context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(doctors[index].employee.name),
                          subtitle: Text(doctors[index].specialty.name),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailDoctor(),
                                settings:
                                    RouteSettings(arguments: doctors[index])));
                          },
                          leading: CircleAvatar(
                            child: Text(
                              '${doctors[index].employee.name[0]}',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          trailing: PopupMenuButton(
                            iconSize: 30,
                            child: Icon(Icons.more_horiz),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                settings: RouteSettings(
                                                    arguments: doctors[index]),
                                                builder: (context) =>
                                                    RegisterDoctor()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          Text(
                                            'Editar',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
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
                                            builder: (context) =>
                                                aletDialogRemove(
                                                    context: context,
                                                    message:
                                                        'Tem certeza que deseja excluir esse paciente',
                                                    callback: (bool value) {
                                                      if (value) {
                                                        doctorProvider
                                                            .removeDoctor(
                                                                doctors[index]);
                                                      }
                                                    }));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          Text(
                                            'Excluir',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          )
                                        ],
                                      )),
                                  value: 'excluir',
                                ),
                              ];
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: doctors.length,
                    padding: EdgeInsets.only(left: 16.0, right: 16.0)))
          ],
        ),
      ),
    );
  }
}
