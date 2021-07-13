import 'package:clinica_medica/screens/medication/find_medication.dart';
import 'package:clinica_medica/screens/medication/store_medication_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/widgets/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Tela principal de Gerenciar Receita onde é possível escolher as opções de
/// Cadastrar receita ou buscar receitas.
class MedicamentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        currentRoute: AppRoutes.MEDICAMENTO_SCREEN,
      ),
      appBar: AppBar(
        title: const Text('Gerenciar Receita'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Cadastrar Receita',
              nav: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoreMedicationScreen(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Receita',
              nav: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FindMedicationScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
