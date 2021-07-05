import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/providers/appointments.dart';
import 'package:clinica_medica/widgets/medical_appointment/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailAppointmentScreen extends StatefulWidget {
  @override
  _DetailAppointmentScreenState createState() =>
      _DetailAppointmentScreenState();
}

class _DetailAppointmentScreenState extends State<DetailAppointmentScreen> {
  Appointment appointment;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    appointment = ModalRoute.of(context).settings.arguments as Appointment;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Appointments appointments = Provider.of<Appointments>(context);
    if (!isLoading) {
      setState(() {
        //atualiza a consulta apos edicao
        appointment = appointments.getItemById(appointment.id);
      });
    }

    final appBar = AppBar(
      title: const Text('Detalhes da consulta'),
      actions: [
        PopupMenu(
          appointment: appointment,
          callback: (bool value) {
            if (value) {
              setState(() {
                isLoading = true;
              });
              Navigator.of(context).pop();
              appointments.removeAppointment(appointment);
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
                  const SizedBox(height: 15),
                  Container(
                    height: 40,
                    child: const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Informações da Consulta',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const Divider(height: 5),
                  Container(
                    height: availableHeight - 60,
                    child: Column(
                      children: [
                        _itemList('Paciente', appointment.patient.name),
                        _itemList(
                            'Data da consulta',
                            new DateFormat('dd/MM/yyyy')
                                .format(appointment.schedule.date)),
                        _itemList('Horário', appointment.schedule.timeBlock),
                        _itemList('Médico', appointment.doctor.name),
                        _itemList('Resultado', ''),
                        _itemText(appointment.result),
                        _itemList('Certificado', ''),
                        _itemText(appointment.certificate),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _itemText(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text ?? '',
          overflow: TextOverflow.fade,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Theme.of(context).accentColor),
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
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value,
                  style: TextStyle(color: Theme.of(context).accentColor)),
            ),
          ),
        ],
      ),
    );
  }
}
