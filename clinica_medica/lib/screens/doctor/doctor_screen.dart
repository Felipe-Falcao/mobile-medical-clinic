import 'package:clinica_medica/screens/doctor/find_doctor.dart';
import 'package:clinica_medica/screens/doctor/register_doctor_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/widgets/patient/menu_tile.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.DOCTOR_SCREEN),
      appBar: AppBar(
        title: Text('Gerenciar Médico'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Cadastrar Paciente',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterDoctor(),
              )),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Paciente',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FindDoctor(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
