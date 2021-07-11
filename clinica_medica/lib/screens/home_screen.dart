import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_medica/infra/auth_connect.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Patients patients = Provider.of<Patients>(context, listen: false);
    Charts charts = Provider.of<Charts>(context, listen: false);
    UserProvider user = Provider.of<UserProvider>(context, listen: false);
    Appointments appointments =
        Provider.of<Appointments>(context, listen: false);
    DoctorProvider doctorProvider =
        Provider.of<DoctorProvider>(context, listen: false);
    AttendantProvider attendantProvider =
        Provider.of<AttendantProvider>(context, listen: false);
    patients.loadPatients();
    charts.loadCharts();
    appointments.loadAppointments();
    doctorProvider.loadDoctors();
    doctorProvider.loadSpecialties();
    attendantProvider.loadAttendants();
    user.loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationFB auth = new AuthenticationFB();
    UserProvider userProv = Provider.of<UserProvider>(context);
    bool isAdmin = userProv.isAdmin;
    bool isAttendant = userProv.isAttendant;
    bool isDoctor = userProv.isDoctor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Sair'),
                    ],
                  ),
                ),
              )
            ],
            onChanged: (item) {
              if (item == 'logout') {
                auth.signOut();
              }
            },
          )
        ],
      ),
      // appBar: AppBar(title: const Text('Home')
      // ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        crossAxisSpacing: 18,
        mainAxisSpacing: 20,
        crossAxisCount: 3,
        childAspectRatio: 9 / 10,
        children: <Widget>[
          _item(
            context: context,
            icons: Icons.attribution_rounded,
            label: 'Gerenciar Atendente',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.ATTENDANT_SCREEN),
            hasAccess: isAdmin,
          ),
          _item(
            context: context,
            icons: Icons.people,
            label: 'Gerenciar Médicos',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.DOCTOR_SCREEN),
            hasAccess: isAdmin,
          ),
          _item(
            context: context,
            icons: Icons.people_alt_rounded,
            label: 'Gerenciar Pacientes',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.PATIENT_SCREEN),
            hasAccess: isAdmin || isAttendant || isDoctor,
          ),
          _item(
            context: context,
            icons: Icons.event_note_rounded,
            label: 'Gerenciar Agendamentos',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.SCHEDULE_SCREEN),
            hasAccess: isAdmin || isAttendant || isDoctor,
          ),
          _item(
            context: context,
            icons: Icons.event_available_rounded,
            label: 'Gerenciar Consulta',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.APPOINTMENT_SCREEN),
            hasAccess: isAdmin || isAttendant || isDoctor,
          ),
          _item(
            context: context,
            icons: Icons.medical_services,
            label: 'Gerenciar Medicamentos',
            nav: null,
            //TODO - aterar quando ger. medicamentos estiver pronto
            hasAccess: false,
            // hasAccess: isAdmin || isDoctor,
          ),
          _item(
            context: context,
            icons: Icons.note_alt_rounded,
            label: 'Gerenciar Prontuário',
            nav: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.CHART_SCREEN),
            hasAccess: isAdmin || isAttendant || isDoctor,
          ),
        ],
      ),
    );
  }

  Widget _item({
    @required BuildContext context,
    @required String label,
    @required Function nav,
    @required IconData icons,
    @required bool hasAccess,
  }) {
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
      child: hasAccess
          ? TextButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(icons,
                          color: Theme.of(context).accentColor, size: 30)),
                  SizedBox(height: 3),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ],
              ),
              onPressed: nav,
            )
          : TextButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(icons, color: Colors.black26)),
                  SizedBox(height: 3),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              onPressed: null,
            ),
    );
  }
}
