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
      centerTitle: true,
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

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

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
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Informações Pessoais',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: availableHeight * 0.22,
                    child: ListView.builder(
                      itemCount: patient.values().length,
                      itemBuilder: (ctx, i) => Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                patient.keys()[i],
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                patient.values()[i],
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Endereço',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: availableHeight * 0.54,
                    child: ListView.builder(
                      itemCount: patient.address.values().length,
                      itemBuilder: (ctx, i) => Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                patient.address.keys()[i],
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                patient.address.values()[i],
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
