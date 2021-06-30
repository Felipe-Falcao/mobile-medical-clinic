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
          _listTile(
            context: context,
            icon: Icons.home_rounded,
            label: 'Home',
            route: AppRoutes.HOME_SCREEN,
          ),
          _listTile(
            context: context,
            icon: Icons.people_alt_rounded,
            label: 'Gerenciar Pacientes',
            route: AppRoutes.PATIENT_SCREEN,
          ),
          _listTile(
            context: context,
            icon: Icons.note_alt_rounded,
            label: 'Gerenciar Prontuário',
            route: AppRoutes.CHART_SCREEN,
          ),
          _listTile(
            context: context,
            icon: Icons.event_available_rounded,
            label: 'Gerenciar Consulta',
            route: AppRoutes.APPOINTMENT_SCREEN,
          ),
          _listTile(
            context: context,
            icon: Icons.event_note_rounded,
            label: 'Gerenciar Agendamentos',
            route: AppRoutes.SCHEDULE_SCREEN,
          ),
        ],
      ),
    );
  }

  Widget _listTile({
    @required BuildContext context,
    @required IconData icon,
    @required String label,
    @required String route,
  }) {
    bool isSelected = currentRoute == route;
    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.teal[50],
      leading: Icon(icon,
          color: isSelected
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor),
      title: Text(label,
          style: TextStyle(
              color:
                  isSelected ? Theme.of(context).accentColor : Colors.black54)),
      onTap: isSelected
          ? null
          : () => Navigator.of(context).pushReplacementNamed(route),
    );
  }
}
