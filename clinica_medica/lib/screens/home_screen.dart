import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
            label: 'Agendamentos',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.SCHEDULE_SCREEN),
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
              offset: Offset.fromDirection(8, 3),
              color: Colors.grey[400],
              blurRadius: 6)
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.cyan[50],
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
          ],
        ),
        onPressed: nav,
      ),
    );
  }
}
