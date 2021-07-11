import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({@required this.currentRoute});
  @override
  Widget build(BuildContext context) {
    UserProvider userProv = Provider.of<UserProvider>(context);
    bool isAdmin = userProv.isAdmin;
    bool isAttendant = userProv.isAttendant;
    bool isDoctor = userProv.isDoctor;
    String name = userProv.user.name.split(" ")[0];
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Bem vindo, $name!'),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(height: 8),
          _listTile(
            context: context,
            icon: Icons.home_rounded,
            label: 'Home',
            route: AppRoutes.HOME_SCREEN,
          ),
          Visibility(
            visible: isAdmin,
            child: _listTile(
              context: context,
              icon: Icons.chat_rounded,
              label: 'Gerenciar Atendente',
              route: AppRoutes.ATTENDANT_SCREEN,
            ),
          ),
          Visibility(
            visible: isAdmin,
            child: _listTile(
              context: context,
              icon: Icons.chat_rounded,
              label: 'Gerenciar Médico',
              route: AppRoutes.DOCTOR_SCREEN,
            ),
          ),
          Visibility(
            visible: isAdmin || isAttendant || isDoctor,
            child: _listTile(
              context: context,
              icon: Icons.people_alt_rounded,
              label: 'Gerenciar Pacientes',
              route: AppRoutes.PATIENT_SCREEN,
            ),
          ),
          Visibility(
            visible: isAdmin || isAttendant || isDoctor,
            child: _listTile(
              context: context,
              icon: Icons.event_note_rounded,
              label: 'Gerenciar Agendamentos',
              route: AppRoutes.SCHEDULE_SCREEN,
            ),
          ),
          Visibility(
            visible: isAdmin || isAttendant || isDoctor,
            child: _listTile(
              context: context,
              icon: Icons.event_available_rounded,
              label: 'Gerenciar Consulta',
              route: AppRoutes.APPOINTMENT_SCREEN,
            ),
          ),
          Visibility(
            visible: isAdmin || isDoctor,
            child: _listTile(
              context: context,
              icon: Icons.medication_rounded,
              label: 'Gerenciar Medicamentos',
              route: AppRoutes.MEDICAMENTO_SCREEN,
            ),
          ),
          Visibility(
            visible: isAdmin || isAttendant || isDoctor,
            child: _listTile(
              context: context,
              icon: Icons.note_alt_rounded,
              label: 'Gerenciar Prontuário',
              route: AppRoutes.CHART_SCREEN,
            ),
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
