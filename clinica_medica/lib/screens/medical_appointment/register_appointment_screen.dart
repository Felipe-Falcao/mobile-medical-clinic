import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/patient.dart';
import 'package:clinica_medica/models/schedule.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/patients.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/medical_appointment/appointment_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAppointmentScreen extends StatefulWidget {
  @override
  _RegisterAppointmentScreenState createState() =>
      _RegisterAppointmentScreenState();
}

class _RegisterAppointmentScreenState extends State<RegisterAppointmentScreen> {
  String _titleScreen = 'Agendar Consulta';
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isValidDate = true;
  bool _isValidPatient = true;
  bool _isValidDoctor = true;
  bool _isLoading = false;
  String _selectedTimeBlock;
  bool _isValidTimeBlock = true;

  @override
  Widget build(BuildContext context) {
    Appointments appointments =
        Provider.of<Appointments>(context, listen: false);
    Patients patients = Provider.of<Patients>(context, listen: false);

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
                height: availableHeight,
                child: Column(
                  children: [
                    AppointmentForm(
                        formData: _formData,
                        form: _form,
                        isValidDate: _isValidDate,
                        isValidPatient: _isValidPatient,
                        isValidDoctor: _isValidDoctor,
                        callback: () {
                          setState(() => _selectedTimeBlock = null);
                        }),
                    SizedBox(height: 12),
                    _selectSchedule(timeBlocks, appointments, patients),
                    if (!_isValidTimeBlock)
                      Row(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 2),
                            child: Text('Selecione um horário!',
                                style: TextStyle(
                                    color: Colors.red[600], fontSize: 13)))
                      ]),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Widget _selectSchedule(
      List<String> timeBlocks, Appointments appointments, Patients patients) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: ListView.builder(
          itemCount: timeBlocks.length,
          itemBuilder: (context, index) {
            bool isSelected = _selectedTimeBlock == timeBlocks[index];
            Appointment appointment = appointments.getByTimeBlock(
                timeBlocks[index], _formData['doctorId'], _formData['date']);
            bool hasPatient = appointment != null;
            Patient patient = patients.getItemById(appointment?.patientId);
            return Container(
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal[50] : null,
              ),
              child: TextButton(
                child: isSelected
                    ? Row(children: [
                        const SizedBox(width: 5),
                        Icon(Icons.radio_button_checked_rounded,
                            size: 18, color: Theme.of(context).accentColor),
                        const SizedBox(width: 10),
                        Text(
                          timeBlocks[index],
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ])
                    : Row(children: [
                        const SizedBox(width: 5),
                        !hasPatient
                            ? Icon(Icons.radio_button_off_rounded,
                                size: 18, color: Colors.black87)
                            : Icon(Icons.event_available_rounded,
                                size: 18, color: Colors.black45),
                        const SizedBox(width: 10),
                        !hasPatient
                            ? Text(timeBlocks[index],
                                style: TextStyle(color: Colors.black87))
                            : Text('${timeBlocks[index]}  -  ${patient.name}',
                                style: TextStyle(color: Colors.black45),
                                overflow: TextOverflow.ellipsis),
                      ]),
                onPressed: !hasPatient
                    ? () =>
                        setState(() => _selectedTimeBlock = timeBlocks[index])
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();
    setState(() {
      _isValidPatient = _formData['patientId'] != null;
      _isValidDoctor = _formData['doctorId'] != null;
      _isValidDate = _formData['date'] != null;
      _isValidTimeBlock = _selectedTimeBlock != null;
    });
    if (!isValid ||
        !_isValidPatient ||
        !_isValidDoctor ||
        !_isValidDate ||
        !_isValidTimeBlock) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    final schedule = Schedule(
      date: _formData['date'],
      timeBlock: _selectedTimeBlock,
    );
    final appointment = Appointment(
      id: _formData['id'],
      patientId: _formData['patientId'],
      doctorId: _formData['doctorId'],
      schedule: schedule,
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
