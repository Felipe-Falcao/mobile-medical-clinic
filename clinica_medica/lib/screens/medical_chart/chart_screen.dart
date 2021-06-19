import 'package:clinica_medica/screens/app_drawer.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.CHART_SCREEN),
      appBar: AppBar(
        title: const Text('Gerenciar Prontuário'),
        centerTitle: true,
      ),
    );
  }
}
