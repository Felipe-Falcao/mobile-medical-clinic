import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/screens/medical_appointment/detail_appointment_screen.dart';
import 'package:clinica_medica/widgets/medical_appointment/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentItem extends StatelessWidget {
  final Appointment appointment;

  AppointmentItem({@required this.appointment});
  @override
  Widget build(BuildContext context) {
    Appointments appointments = Provider.of<Appointments>(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailAppointmentScreen(),
              settings: RouteSettings(arguments: appointment)));
        },
        leading: CircleAvatar(
          child: Icon(
            Icons.event_available_rounded,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(appointment.patient.name),
        subtitle: Text(
            'Data: ${DateFormat('dd/MM/yyyy').format(appointment.schedule.date)}'),
        trailing: PopupMenu(
          appointment: appointment,
          callback: (bool value) {
            if (value) {
              appointments.removeAppointment(appointment);
            }
          },
        ),
      ),
    );
  }
}
