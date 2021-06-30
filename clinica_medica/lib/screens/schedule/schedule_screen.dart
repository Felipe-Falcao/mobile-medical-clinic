import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/models/schedule.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/screens/medical_appointment/detail_appointment_screen.dart';
import 'package:clinica_medica/utils/app_routes.dart';
import 'package:clinica_medica/widgets/app_drawer.dart';
import 'package:clinica_medica/widgets/schedule/schedule_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isValidDate = true;
  bool _isValidDoctor = true;
  bool _isValidTimeBlock = true;

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<Appointments>(context);

    final appBar = AppBar(
      title: Text('Agendamentos'),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      drawer: AppDrawer(currentRoute: AppRoutes.SCHEDULE_SCREEN),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: availableHeight,
          child: Column(
            children: [
              ScheduleForm(
                  formData: _formData,
                  form: _form,
                  isValidDate: _isValidDate,
                  isValidDoctor: _isValidDoctor,
                  callback: () {
                    setState(() {});
                  }),
              const SizedBox(height: 12),
              _schedule(timeBlocks, appointments),
              if (!_isValidTimeBlock)
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 2),
                      child: Text('Selecione um horário!',
                          style:
                              TextStyle(color: Colors.red[600], fontSize: 13)))
                ]),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _schedule(List<String> timeBlocks, Appointments appointments) {
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
            Appointment appointment = appointments.getByTimeBlock(
                timeBlocks[index], _formData['doctor'], _formData['date']);
            bool hasPatient = appointment != null;
            return Container(
              height: 45,
              decoration: BoxDecoration(
                color: hasPatient ? Colors.teal[50] : null,
              ),
              child: TextButton(
                child: hasPatient
                    ? Row(children: [
                        const SizedBox(width: 5),
                        Icon(Icons.person_pin_rounded,
                            color: Theme.of(context).accentColor),
                        const SizedBox(width: 10),
                        Text(
                            '${timeBlocks[index]}  -  ${appointment.patient.name}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15)),
                        Expanded(child: SizedBox()),
                        Icon(Icons.arrow_right,
                            color: Theme.of(context).accentColor)
                      ])
                    : Row(children: [
                        const SizedBox(width: 5),
                        Icon(Icons.event_note_rounded, color: Colors.black38),
                        const SizedBox(width: 10),
                        Text(timeBlocks[index],
                            style: TextStyle(color: Colors.black54))
                      ]),
                onPressed: hasPatient
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailAppointmentScreen(),
                            settings: RouteSettings(arguments: appointment)));
                      }
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
