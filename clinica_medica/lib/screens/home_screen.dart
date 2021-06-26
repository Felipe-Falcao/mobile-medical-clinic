import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              child: Text('Gerenciar Pacientes'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.PATIENT_SCREEN);
              },
            ),
            TextButton(
              child: Text('Gerenciar Prontuário'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.CHART_SCREEN);
              },
            ),
            TextButton(
              child: Text('Gerenciar Consulta'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.APPOINTMENT_SCREEN);
              },
            ),
            TextButton(
              child: Text('Agendamentos'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.SCHEDULE_SCREEN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
