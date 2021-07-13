import 'package:clinica_medica/screens/medical_appointment/register_appointment_screen.dart';
import 'package:clinica_medica/screens/medical_appointment/find_appointment_screen.dart';
import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/menu_tile.dart';
import 'package:flutter/material.dart';

/*
* Responsavel por renderizar a tela principal de gerenciar consultas
*/
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
                builder: (context) => RegisterAppointmentScreen(),
              )),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Consulta',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FindAppointmentScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
