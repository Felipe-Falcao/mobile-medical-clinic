import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Patients patients = Provider.of<Patients>(context, listen: false);
    Charts charts = Provider.of(context, listen: false);
    patients.loadPatients();
    charts.loadCharts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        crossAxisSpacing: 28,
        mainAxisSpacing: 20,
        crossAxisCount: 3,
        childAspectRatio: 9 / 10,
        children: <Widget>[
          _item(
            context: context,
            icons: Icons.people_alt_rounded,
            label: 'Gerenciar Pacientes',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.PATIENT_SCREEN),
          ),
          _item(
            context: context,
            icons: Icons.note_alt_rounded,
            label: 'Gerenciar Prontuário',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.CHART_SCREEN),
          ),
          _item(
            context: context,
            icons: Icons.event_available_rounded,
            label: 'Gerenciar Consulta',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.APPOINTMENT_SCREEN),
          ),
          _item(
            context: context,
            icons: Icons.event_note_rounded,
            label: 'Gerenciar Agendamentos',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.SCHEDULE_SCREEN),
          ),
          _item(
            context: context,
            icons: Icons.people,
            label: 'Gerenciar Médicos',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.DOCTOR_SCREEN),
          ),
        ],
      ),
    );
  }

  Widget _item(
      {@required BuildContext context,
      @required String label,
      @required Function nav,
      @required IconData icons}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(8, 4),
            color: Colors.grey[350],
            blurRadius: 15,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: TextButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(icons, color: Theme.of(context).accentColor)),
            SizedBox(height: 3),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 13),
            ),
            TextButton(
              child: Text('Gerenciar Médico'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.DOCTOR_SCREEN);
              },
            ),
          ],
        ),
        onPressed: nav,
      ),
    );
  }
}
