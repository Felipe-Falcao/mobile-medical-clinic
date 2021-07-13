import 'package:clinica_medica/models/receita.dart';
import 'package:clinica_medica/providers/medication_provider.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/medication/medication_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Classe responsável por realizar o cadastro de uma receita
class StoreMedicationScreen extends StatefulWidget {
  @override
  _StoreMedicationState createState() => _StoreMedicationState();
}

class _StoreMedicationState extends State<StoreMedicationScreen> {
  String _titleScreen = 'Cadastrar Receita';
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isValidMedication = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(_titleScreen),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: _isLoading
          ? const Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
              height: availableHeight - 100,
              child: Column(
                children: [
                  MedicationForm(
                    currentMode: _titleScreen,
                    form: _form,
                    formData: _formData,
                    isValidMedication: _isValidMedication,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, bottom: 20, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cancelButton(
                            context, () => Navigator.of(context).pop()),
                        finishButton(context, _saveForm),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  /// Método chamado quando uma dependência (Estado) do objeto muda.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final Receita receita =
          ModalRoute.of(context).settings.arguments as Receita;

      if (receita != null) {
        setState(() {
          _titleScreen = 'Editar Receita';
        });

        _formData['id'] = receita.id;
        _formData['dataPescricao'] = receita.dataPrescricao;
        _formData['dose'] = receita.dose;
        _formData['nome'] = receita.nome;
        _formData['refMedico'] = receita.refMedico;
        _formData['refPaciente'] = receita.refPaciente;
      }
    }
  }

  /// Formulário Cadastrar Receita:
  /// Campos: Nome, Dose, Data da Prescrição, IDs do médico e paciente.
  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();

    setState(() {
      _isValidMedication = _formData['refPaciente'] != null;
    });

    if (!isValid || !_isValidMedication) {
      return null;
    }

    _form.currentState.save();

    final receita = Receita(
      id: _formData['id'],
      dataPrescricao: DateTime.now(),
      dose: _formData['dose'],
      nome: _formData['nome'],
      refMedico: 'qVLN2s87OXOA4OrRdnBY8utKZDw2', // _formData['refMedico'],
      refPaciente: _formData['refPaciente'],
    );

    setState(() {
      _isLoading = true;
    });

    final medications = Provider.of<Medication>(context, listen: false);

    try {
      if (_formData['id'] == null) {
        await medications.addMedication(receita);
      } else {
        await medications.updateMedication(receita);
      }

      await showDialog(
        context: context,
        builder: (ctx) => aletDialogSuccess(
          context: ctx,
          message: 'Receita foi cadastrada com sucesso.',
        ),
      );

      Navigator.of(context).pop();
    } catch (erro) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro pra salvar o medicamento!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
