import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({@required this.currentRoute});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Bem vindo!'),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            enabled: currentRoute != AppRoutes.HOME_SCREEN,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_SCREEN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt_rounded),
            title: const Text('Gerenciar Pacientes'),
            enabled: currentRoute != AppRoutes.PATIENT_SCREEN,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.PATIENT_SCREEN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_rounded),
            title: const Text('Gerenciar Prontuário'),
            enabled: currentRoute != AppRoutes.CHART_SCREEN,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.CHART_SCREEN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_rounded),
            title: const Text('Gerenciar Consulta'),
            enabled: currentRoute != AppRoutes.APPOINTMENT_SCREEN,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.APPOINTMENT_SCREEN);
            },
          ),
        ],
      ),
    );
  }
}
