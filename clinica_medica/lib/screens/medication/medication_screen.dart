import 'package:clinica_medica/widgets/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MedicamentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Medicamento'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuTile(
              title: 'Cadastrar Medicamento',
              nav: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MenuTile(
              title: 'Buscar Medicamento',
              nav: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
