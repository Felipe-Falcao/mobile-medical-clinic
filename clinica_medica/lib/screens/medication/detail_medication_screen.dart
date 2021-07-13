import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/receita.dart';
import 'package:clinica_medica/providers/medication_provider.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/medication/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// Classe responsável por exibir as informações de uma receita na tela.
class DetailMedicationScreen extends StatefulWidget {
  @override
  _DetailMedicationScreenState createState() => _DetailMedicationScreenState();
}

class _DetailMedicationScreenState extends State<DetailMedicationScreen> {
  Receita receita;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    receita = ModalRoute.of(context).settings.arguments as Receita;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Medication receitas = Provider.of<Medication>(context);
    Patient patient = Provider.of<Patients>(context, listen: false)
        .getItemById(receita.refPaciente);

    if (!isLoading) {
      setState(() {
        //atualiza a receita apos edicao
        receita = receitas.getItemById(receita.id);
      });
    }

    final appBar = AppBar(
      title: const Text('Receita'),
      actions: [
        ReceitaMenu(
          receita: receita,
          callback: (bool value) {
            if (value) {
              setState(() => isLoading = true);
              Navigator.of(context).pop();
              receitas.removeMedication(receita);
            }
          },
          icon: Icon(Icons.more_vert_rounded),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Informações da Receita',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const Divider(height: 10),
                  Container(
                    height: availableHeight - 70,
                    child: Column(
                      children: [
                        _itemList('Paciente', patient.name),
                        _itemList(
                          'Data da Prescrição',
                          new DateFormat('dd/MM/yyyy')
                              .format(receita.dataPrescricao),
                        ),
                        _itemList('Dose', ''),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              receita.dose,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _itemList(String key, String value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(key, style: TextStyle(color: Colors.black54)),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(value,
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
        ],
      ),
    );
  }
}
