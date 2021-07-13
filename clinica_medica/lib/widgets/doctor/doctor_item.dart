import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/screens/doctor/detail_doctor.dart';
import 'package:clinica_medica/widgets/doctor/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classe que cria o componente que apresenta os items da lista de médicos
class DoctorItem extends StatelessWidget {
  final Doctor doctor;
  const DoctorItem({@required this.doctor});

  @override
  Widget build(BuildContext context) {
    DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context);
    Appointments appointments =
        Provider.of<Appointments>(context, listen: false);
    return Card(
      child: ListTile(
          title: Text(doctor.employee.name),
          subtitle: Text(doctor.specialty.name),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailDoctor(),
                settings: RouteSettings(arguments: doctor)));
          },
          leading: CircleAvatar(
            child: Text(
              '${doctor.employee.name[0]}',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          trailing: PopupMenu(
            doctor: doctor,
            callback: (bool value) {
              if (value) {
                appointments
                    .removeAppointmentsWith(doctor.id)
                    .then((_) => doctorProvider.removeDoctor(doctor));
              }
            },
          )),
    );
  }
}
