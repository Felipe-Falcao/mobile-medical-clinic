import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/*
* Responsavel por renderizar a tela para edicao de uma consulta
*/
class EditAppointmentScreen extends StatefulWidget {
  @override
  _EditAppointmentScreenState createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  Appointment appointment;
  final _formData = new Map<String, Object>();
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    DoctorProvider doctorProv =
        Provider.of<DoctorProvider>(context, listen: false);
    Patients patients = Provider.of<Patients>(context, listen: false);
    Patient patient = patients.getItemById(appointment?.patientId);
    Doctor doctor = doctorProv.getItemById(appointment?.doctorId);
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Consulta')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    _itemList('Paciente', patient.name),
                    _itemList(
                        'Data da consulta',
                        new DateFormat('dd/MM/yyyy')
                            .format(appointment.schedule.date)),
                    _itemList('Horário', appointment.schedule.timeBlock),
                    _itemList('Médico', doctor.employee.name),
                    const SizedBox(height: 15),
                    _textBox(
                      key: 'result',
                      label: 'Resultado',
                      message:
                          'Informe uma resultado válido com no mínimo 10 caracteres!',
                    ),
                    const SizedBox(height: 15),
                    _textBox(
                      key: 'certificate',
                      label: 'Atestado',
                      message:
                          'Informe um atestado válido com no mínimo 10 caracteres!',
                    ),
                    Container(
                      height: 100,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
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
              ),
            ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      appointment = ModalRoute.of(context).settings.arguments as Appointment;
      if (appointment != null) {
        _formData['id'] = appointment.id;
        _formData['patientId'] = appointment.patientId;
        _formData['doctorId'] = appointment.doctorId;
        _formData['schedule'] = appointment.schedule;
        _formData['result'] = appointment.result;
        _formData['certificate'] = appointment.certificate;
      }
    }
  }

  Widget _textBox({
    @required String key,
    @required String label,
    @required String message,
  }) {
    return TextFormField(
      key: ValueKey(key),
      autofocus: true,
      initialValue: _formData[key],
      maxLines: 10,
      minLines: 4,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14.0, color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.next,
      onChanged: (value) => _formData[key] = value,
      validator: (value) {
        bool isEmpty = value.trim().isEmpty;
        bool isInvalid = value.trim().length < 10;
        if (isEmpty || isInvalid) {
          return message;
        }
        return null;
      },
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

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    setState(() => _isLoading = true);
    final appointment = Appointment(
      id: _formData['id'],
      patientId: _formData['patientId'],
      doctorId: _formData['doctorId'],
      schedule: _formData['schedule'],
      result: _formData['result'],
      certificate: _formData['certificate'],
    );
    final appointments = Provider.of<Appointments>(context, listen: false);
    try {
      if (_formData['id'] == null) {
        appointments.addAppointment(appointment);
      } else {
        appointments.updateAppointment(appointment);
      }
      await showDialog<Null>(
        context: context,
        builder: (ctx) => aletDialogSuccess(
          context: ctx,
          message: 'A Consulta foi cadastrada com sucesso.',
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro pra salvar a Consulta!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
