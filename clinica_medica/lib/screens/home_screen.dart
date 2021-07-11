import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/screens/user/user_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    UserProvider userProv = Provider.of<UserProvider>(context);
    bool isAdmin = userProv.isAdmin;
    bool isAttendant = userProv.isAttendant;
    bool isDoctor = userProv.isDoctor;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height * .27,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(children: [
                Text(
                  'Clinic+',
                  style: TextStyle(fontFamily: 'Iceberg', fontSize: 40),
                ),
                Spacer(),
                if (userProv.user != null)
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Text(userProv.firstName,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(
                            Icons.account_circle_rounded,
                            color: Theme.of(context).accentColor,
                            size: 25,
                          ),
                        ],
                      ),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserScreen(),
                      )),
                    ),
                  ),
              ]),
            ),
          ),
          Column(
            children: [
              SizedBox(height: size.height * .18),
              Container(
                height: size.height * .72,
                child: GridView.count(
                  primary: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                      label: 'Gerenciar Médico',
                      nav: () => Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.DOCTOR_SCREEN),
                      hasAccess: isAdmin,
                    ),
                    _item(
                      context: context,
                      icons: Icons.people_alt_rounded,
                      label: 'Gerenciar Paciente',
                      nav: () => Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.PATIENT_SCREEN),
                      hasAccess: isAdmin || isAttendant || isDoctor,
                    ),
                    _item(
                      context: context,
                      icons: Icons.event_note_rounded,
                      label: 'Gerenciar Agendamento',
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
                      label: 'Gerenciar Medicamento',
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
              ),
            ],
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
