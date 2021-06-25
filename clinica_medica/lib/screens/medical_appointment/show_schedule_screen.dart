import 'package:clinica_medica/providers/appointments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<Appointments>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Agendamento'),
      ),
      body: ListView.builder(
          itemCount: appointments.itemsCount,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Text(appointments.items[i].patient.name),
              ),
            );
          }),
    );
  }
}

// const SizedBox(height: 15),
                    // _textBox(
                    //   key: 'result',
                    //   label: 'Resultado',
                    //   message:
                    //       'Informe uma resultado válido com no mínimo 10 caracteres!',
                    // ),
                    // const SizedBox(height: 15),
                    // _textBox(
                    //   key: 'certificate',
                    //   label: 'Atestado',
                    //   message:
                    //       'Informe um atestado válido com no mínimo 10 caracteres!',
                    // ),

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_formData.isEmpty) {
  //     final Appointment appointment =
  //         ModalRoute.of(context).settings.arguments as Appointment;
  //     if (appointment != null) {
  //       setState(() {
  //         _titleScreen = 'Editar Consulta';
  //       });
  //       _formData['id'] = appointment.id;
  //       _formData['patient'] = appointment.patient;
  //       _formData['doctor'] = appointment.doctor;
  //       _formData['schedule'] = appointment.schedule;
  //       _formData['result'] = appointment.result;
  //       _formData['certificate'] = appointment.certificate;
  //     }
  //   }
  // }

  // Widget _textBox({
  //   @required String key,
  //   @required String label,
  //   @required String message,
  // }) {
  //   return TextFormField(
  //     key: ValueKey(key),
  //     autofocus: true,
  //     initialValue: _formData[key],
  //     maxLines: 10,
  //     minLines: 4,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       labelStyle: TextStyle(fontSize: 14.0, color: Colors.black54),
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //       filled: true,
  //       fillColor: Theme.of(context).inputDecorationTheme.fillColor,
  //       border: const OutlineInputBorder(
  //         borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
  //         borderSide: BorderSide.none,
  //       ),
  //     ),
  //     textInputAction: TextInputAction.next,
  //     onChanged: (value) => _formData[key] = value,
  //     validator: (value) {
  //       bool isEmpty = value.trim().isEmpty;
  //       bool isInvalid = value.trim().length < 10;
  //       if (isEmpty || isInvalid) {
  //         return message;
  //       }
  //       return null;
  //     },
  //   );
  // }
