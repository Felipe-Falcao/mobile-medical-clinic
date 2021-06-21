import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patient/patients.dart';
import 'package:clinica_medica/widgets/patient/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPatientScreen extends StatefulWidget {
  @override
  _DetailPatientScreenState createState() => _DetailPatientScreenState();
}

class _DetailPatientScreenState extends State<DetailPatientScreen> {
  Patient patient;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    patient = ModalRoute.of(context).settings.arguments as Patient;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Patients patients = Provider.of<Patients>(context);
    if (!isLoading) {
      setState(() {
        patient = patients.getItemById(patient.id);
      });
    }

    final appBar = AppBar(
      title: const Text('Paciente'),
      actions: [
        PopupMenu(
          patient: patient,
          callback: (bool value) {
            if (value) {
              setState(() {
                isLoading = true;
              });
              Navigator.of(context).pop();
              patients.removePatient(patient);
            }
          },
          icon: Icon(Icons.more_vert_rounded),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Informações Pessoais',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const Divider(height: 10),
                  Container(
                    height: 130,
                    child: ListView.builder(
                        itemCount: patient.values().length,
                        itemBuilder: (ctx, i) =>
                            _itemList(patient.keys()[i], patient.values()[i])),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('Endereço',
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const Divider(height: 10),
                  Container(
                    height: 170,
                    child: ListView.builder(
                      itemCount: patient.address.values().length,
                      itemBuilder: (ctx, i) => _itemList(
                          patient.address.keys()[i],
                          patient.address.values()[i]),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _itemList(String key, String value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              key,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Container(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                overflow: TextOverflow.fade,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
