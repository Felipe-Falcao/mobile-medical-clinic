import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/schedule.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/widgets/buttons_alerts/alerts.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/medical_appointment/appointment_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> timeBlocks = [
  '8:00',
  '8:30',
  '9:00',
  '9:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14:00',
  '14:30',
  '15:00',
  '15:30',
  '16:00',
  '16:30',
  '17:00',
  '17:30'
];

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
    final appointments = Provider.of<Appointments>(context, listen: false);

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
                          setState(() {
                            _selectedTimeBlock = null;
                          });
                        }),
                    SizedBox(height: 12),
                    _selectSchedule(timeBlocks, appointments),
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

  Widget _selectSchedule(List<String> timeBlocks, Appointments appointments) {
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
                timeBlocks[index], _formData['doctor'], _formData['date']);
            bool hasPatient = appointment != null;
            String patientName =
                hasPatient ? '  -  ${appointment.patient.name}' : '';
            return Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal[50] : null,
              ),
              child: TextButton(
                child: isSelected
                    ? Row(children: [
                        const SizedBox(width: 5),
                        Icon(Icons.radio_button_checked_rounded,
                            color: Theme.of(context).accentColor),
                        const SizedBox(width: 10),
                        Text('${timeBlocks[index]} $patientName',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18))
                      ])
                    : Row(children: [
                        const SizedBox(width: 5),
                        !hasPatient
                            ? Icon(Icons.radio_button_off_rounded,
                                color: Colors.black87)
                            : Icon(Icons.push_pin_sharp, color: Colors.black45),
                        const SizedBox(width: 10),
                        !hasPatient
                            ? Text('${timeBlocks[index]} $patientName',
                                style: TextStyle(color: Colors.black87))
                            : Text('${timeBlocks[index]} $patientName',
                                style: TextStyle(color: Colors.black45)),
                      ]),
                onPressed: !hasPatient
                    ? () {
                        setState(() {
                          _selectedTimeBlock = timeBlocks[index];
                        });
                      }
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
      _isValidPatient = _formData['patient'] != null;
      _isValidDoctor = _formData['doctor'] != null;
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
      patient: _formData['patient'],
      doctor: _formData['doctor'],
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
      setState(() {
        _isLoading = false;
      });
    }
  }
}
