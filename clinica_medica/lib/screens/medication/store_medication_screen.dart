import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreMedicationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoreMedicationState();
  }
}

class StoreMedicationState extends State<StoreMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Medicamento'),
      ),
      body: null,
    );
  }
}
