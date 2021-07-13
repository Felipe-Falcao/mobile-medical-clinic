import 'package:clinica_medica/screens/attendant/find_attendant_screen.dart';
import 'package:clinica_medica/screens/attendant/register_attendant_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/widgets/menu_tile.dart';
import 'package:flutter/material.dart';

//Classe que cria a tela de onde são listadas as funcionalidades relacionadas
//a atendente
class AttendantScreen extends StatelessWidget {
  const AttendantScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.ATTENDANT_SCREEN),
      appBar: AppBar(
        title: Text('Gerenciar Atendente'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Cadastrar Atendente',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterAttendantScreen(),
              )),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Atendente',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FindAttendantScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
