// import 'package:clinica_medica/infra/auth_connect.dart';
// import 'package:clinica_medica/infra/funcionario_connect.dart';
// import 'package:clinica_medica/screens/auth_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//https://saveyourtime.medium.com/firebase-cloud-firestore-add-set-update-delete-get-data-6da566513b1b
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/providers/medical_chart/charts.dart';
import 'package:clinica_medica/providers/patient/patients.dart';
import 'package:clinica_medica/screens/doctor/doctor_screen.dart';
import 'package:clinica_medica/screens/home_screen.dart';
import 'package:clinica_medica/screens/medical_chart/chart_screen.dart';
import 'package:clinica_medica/screens/patient/patient_screen.dart';
import 'package:clinica_medica/screens/splash_screen.dart';
import 'package:clinica_medica/theme/theme.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // if (USE_FIRESTORE_EMULATOR) {
  //   FirebaseFirestore.instance.settings = const Settings(
  //       host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // AuthenticationFB auth = new AuthenticationFB();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Patients(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Charts(),
        ),
        ChangeNotifierProvider(create: (_) => new DoctorProvider()),
      ],
      child: MaterialApp(
        title: 'Clinic+',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: SplashScreen(),
        routes: {
          AppRoutes.HOME_SCREEN: (ctx) => HomeScreen(),
          AppRoutes.PATIENT_SCREEN: (ctx) => PatientScreen(),
          AppRoutes.CHART_SCREEN: (ctx) => ChartScreen(),
          AppRoutes.DOCTOR_SCREEN: (ctx) => DoctorScreen()
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   final AuthenticationFB auth = new AuthenticationFB();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Integração Firebase',
//       debugShowCheckedModeBanner: false,
//       theme: appTheme,
          /*ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color(0xFF72D5BF),
            backgroundColor: Colors.white,
            accentColor: Color(0xFF001524),
            accentColorBrightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Color(0xFF001524),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            appBarTheme: AppBarTheme(centerTitle: true)),*/
//       home: AuthScreen(),
//       home: StreamBuilder(
//         stream: auth.isLogged(),
//         builder: (ctx, userSnapshot) {
//           if (userSnapshot.hasData) {
//             return MyHomePage();
//           } else {
//             return AuthScreen();
//           }
//         },
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   AuthenticationFB auth = new AuthenticationFB();
//   FuncionarioFB func = new FuncionarioFB();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Integração Firebase'),
//         actions: [
//           DropdownButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: Theme.of(context).primaryIconTheme.color,
//             ),
//             items: [
//               DropdownMenuItem(
//                 value: 'logout',
//                 child: Container(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.exit_to_app,
//                         color: Colors.black,
//                       ),
//                       SizedBox(width: 8),
//                       Text('Sair'),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//             onChanged: (item) {
//               if (item == 'logout') {
//                 auth.signOut();
//               }
//             },
//           )
//         ],
//       ),
//       body: StreamBuilder(
//         // READ ALL
//         stream: func.readAll(),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final documents = snapshot.data;
//           return ListView.builder(
//             itemCount: documents.size,
//             itemBuilder: (ctx, i) => Container(
//               padding: EdgeInsets.all(10),
//               child: Text(documents.docs[i]['nome']),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // AtendenteFB atendenteFB = new AtendenteFB();
//           // atendenteFB.create(6000, 'VzOkRMHXQkOOAgAMqfnXmw60N9p1', 'Manhã');
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }