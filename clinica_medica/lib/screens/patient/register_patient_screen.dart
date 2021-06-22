import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/patient/patient_timeline.dart';
import 'package:clinica_medica/widgets/patient/forms/patient_form_step1.dart';
import 'package:clinica_medica/widgets/patient/forms/patient_form_step2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPatientScreen extends StatefulWidget {
  @override
  _RegisterPatientScreenState createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  String _titleScreen = 'Cadastrar Paciente';
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isValidDate = true;
  bool _isLoading = false;
  int _step = 1;

  int _processIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(_titleScreen),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (_step == 1) {
            Navigator.of(context).pop();
          } else {
            _previousStep();
          }
        },
      ),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: _isLoading
          ? const Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: PatientTimeline(_processIndex),
                  ),
                  Container(
                    height: availableHeight - 100,
                    child: Column(
                      children: [
                        if (_step == 1)
                          PatientFormStep1(
                            formData: _formData,
                            form: _form,
                            isValidDate: _isValidDate,
                          ),
                        if (_step == 2) PatientFormStep2(_formData, _form),
                        if (_step == 1)
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 20, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cancelButton(
                                    context, () => Navigator.of(context).pop()),
                                nextButton(context, _nextStep),
                              ],
                            ),
                          ),
                        if (_step == 2)
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 20, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                previousButton(context, _previousStep),
                                finishButton(context, _saveForm),
                              ],
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final Patient patient =
          ModalRoute.of(context).settings.arguments as Patient;
      if (patient != null) {
        setState(() {
          _titleScreen = 'Editar Paciente';
        });
        _formData['id'] = patient.id;
        _formData['name'] = patient.name;
        _formData['phoneNumber'] = patient.phoneNumber;
        _formData['cpf'] = patient.cpf;
        _formData['birthDate'] = patient.birthDate;
        _formData['street'] = patient.address.street;
        _formData['number'] = patient.address.number;
        _formData['zipCode'] = patient.address.zipCode;
        _formData['city'] = patient.address.city;
        _formData['state'] = patient.address.state;
      }
    }
  }

  void _nextStep() {
    var isValid = _form.currentState.validate();
    setState(() => _isValidDate = _formData['birthDate'] != null);
    if (!isValid || !_isValidDate) return;
    setState(() {
      _step++;
      _processIndex = (_processIndex + 1) % 2; //2 = steps
    });
  }

  void _previousStep() {
    setState(() {
      _step--;
      _processIndex = (_processIndex - 1) % 2; //2 = steps
    });
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    final address = Address(
      street: _formData['street'],
      number: _formData['number'],
      zipCode: _formData['zipCode'],
      city: _formData['city'],
      state: _formData['state'],
    );
    final patient = Patient(
      id: _formData['id'],
      name: _formData['name'],
      phoneNumber: _formData['phoneNumber'],
      cpf: _formData['cpf'],
      birthDate: _formData['birthDate'],
      address: address,
    );
    setState(() {
      _isLoading = true;
    });
    final patients = Provider.of<Patients>(context, listen: false);
    try {
      if (_formData['id'] == null) {
        patients.addPatient(patient);
      } else {
        patients.updatePatient(patient);
      }
      await showDialog<Null>(
        context: context,
        builder: (ctx) => aletDialogSuccess(
          context: ctx,
          message: 'O paciente foi cadastrado com sucesso.',
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro pra salvar o paciente!'),
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
