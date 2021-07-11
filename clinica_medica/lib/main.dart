import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/providers/charts.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/providers/user.dart';
import 'package:clinica_medica/screens/attendant/attendant_screen.dart';
import 'package:clinica_medica/screens/auth_screen.dart';
import 'package:clinica_medica/screens/doctor/doctor_screen.dart';
import 'package:clinica_medica/screens/home_screen.dart';
import 'package:clinica_medica/screens/medical_appointment/appointment_screen.dart';
import 'package:clinica_medica/screens/medical_chart/chart_screen.dart';
import 'package:clinica_medica/screens/patient/patient_screen.dart';
import 'package:clinica_medica/screens/schedule/schedule_screen.dart';
import 'package:clinica_medica/theme/theme.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationFB auth = new AuthenticationFB();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new Patients()),
        ChangeNotifierProvider(create: (_) => new Charts()),
        ChangeNotifierProvider(create: (_) => new Appointments()),
        ChangeNotifierProvider(create: (_) => new UserProvider()),
        ChangeNotifierProvider(create: (_) => new DoctorProvider()),
        ChangeNotifierProvider(create: (_) => new AttendantProvider()),
      ],
      child: MaterialApp(
        title: 'Clinic+',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: _home(),
        routes: {
          AppRoutes.HOME_SCREEN: (_) => _home(),
          AppRoutes.PATIENT_SCREEN: (_) => PatientScreen(),
          AppRoutes.CHART_SCREEN: (_) => ChartScreen(),
          AppRoutes.APPOINTMENT_SCREEN: (_) => AppointmentScreen(),
          AppRoutes.SCHEDULE_SCREEN: (_) => ScheduleScreen(),
          AppRoutes.DOCTOR_SCREEN: (_) => DoctorScreen(),
          AppRoutes.ATTENDANT_SCREEN: (_) => AttendantScreen()
        },
      ),
    );
  }

  _home() => StreamBuilder(
        stream: auth.isLogged(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return HomeScreen();
          } else {
            return AuthScreen();
          }
        },
      );
}
