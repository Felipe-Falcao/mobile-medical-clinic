import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/screens/patient/charts_patient_screen.dart';
import 'package:clinica_medica/widgets/patient/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
* Responsavel por renderizar a tela de detalhes de um paciente
*/
class DetailPatientScreen extends StatefulWidget {
  @override
  _DetailPatientScreenState createState() => _DetailPatientScreenState();
}

class _DetailPatientScreenState extends State<DetailPatientScreen> {
  Patient patient;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context).settings.arguments != null)
      patient = ModalRoute.of(context).settings.arguments as Patient;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Patients patients = Provider.of<Patients>(context);
    Charts charts = Provider.of<Charts>(context, listen: false);
    Appointments appointments =
        Provider.of<Appointments>(context, listen: false);
    if (!isLoading) {
      setState(() {
        //atualiza o paciente apos edicao
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
              setState(() => isLoading = true);
              appointments.removeAppointmentsWith(patient.id).then(
                    (_) => charts.removeChartsWith(patient.id).then(
                          (_) => patients.removePatient(patient).then(
                                (_) => Navigator.of(context).pop(),
                              ),
                        ),
                  );
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
                        itemCount: patient.toMap.length,
                        itemBuilder: (ctx, i) => _itemList(
                            patient.toMap.keys.toList()[i],
                            patient.toMap.values.toList()[i].toString())),
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
                      itemCount: patient.address.toMap.length,
                      itemBuilder: (ctx, i) => _itemList(
                          patient.address.toMap.keys.toList()[i],
                          patient.address.toMap.values.toList()[i].toString()),
                    ),
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mostrar prontuários cadastrados',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ChartsPatientScreen(patient)));
                      },
                    ),
                  )
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
            child: Text(key, style: TextStyle(color: Colors.black54)),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(value,
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
        ],
      ),
    );
  }
}
