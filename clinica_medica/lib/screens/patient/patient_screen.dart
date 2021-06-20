import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/screens/patient/find_patient_screen.dart';
import 'package:clinica_medica/screens/patient/register_patient_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/patient/menu_tile.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.PATIENT_SCREEN),
      appBar: AppBar(
        title: const Text('Gerenciar Paciente'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Cadastrar Paciente',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterPatientScreen(),
              )),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Paciente',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FindPatientScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
