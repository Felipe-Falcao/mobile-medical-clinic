import 'package:clinica_medica/screens/medical_appointment/schedule_appointment_screen.dart';
import 'package:clinica_medica/screens/medical_appointment/show_schedule_screen.dart';
import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/patient/menu_tile.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.APPOINTMENT_SCREEN),
      appBar: AppBar(
        title: const Text('Gerenciar Consulta'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Agendar Consulta',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScheduleAppointmentScreen(),
              )),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Consultar Agendamento',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowScheduleScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
