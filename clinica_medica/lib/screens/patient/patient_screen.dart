import 'package:clinica_medica/screens/app_drawer.dart';
import 'package:clinica_medica/screens/patient/find_patient_screen.dart';
import 'package:clinica_medica/screens/patient/register_patient_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.PATIENT_SCREEN),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gerenciar Paciente'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _listTile(
              'Cadastrar Paciente',
              () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterPatientScreen(),
              )),
            ),
            const SizedBox(height: 20),
            _listTile(
              'Buscar Paciente',
              () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FindPatientScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(String title, Function nav) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      child: TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black87)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Icon(Icons.arrow_forward_ios)],
        ),
        onPressed: nav,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.black12,
      ),
    );
  }
}
