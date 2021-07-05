import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/screens/medical_chart/find_chart_screen.dart';
import 'package:clinica_medica/screens/medical_chart/register_chart_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/menu_tile.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.CHART_SCREEN),
      appBar: AppBar(
        title: const Text('Gerenciar Prontuário'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Cadastrar Prontuário',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterChartScreen(),
              )),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Prontuário',
              nav: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FindChartScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
