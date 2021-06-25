import 'package:clinica_medica/models/appointment.dart';
import 'package:clinica_medica/widgets/buttons_alerts/buttons.dart';
import 'package:clinica_medica/widgets/medical_appointment/appointment_form.dart';
import 'package:flutter/material.dart';

List<String> timeBlocks = [
  'H8M00',
  'H8M30',
  'H9M00',
  'H9M30',
  'H10M00',
  'H10M30',
  'H11M00',
  'H11M30',
  'H12M00',
  'H12M30',
  'H13M00',
  'H13M30',
  'H14M00',
  'H14M30',
  'H15M00',
  'H15M30',
  'H16M00',
  'H16M30',
  'H17M00',
  'H17M30'
];

class ScheduleAppointmentScreen extends StatefulWidget {
  @override
  _ScheduleAppointmentScreenState createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  String _titleScreen = 'Agendar Consulta';
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isValidDate = true;
  bool _isValidPatient = true;
  bool _isValidDoctor = true;
  bool _isLoading = false;

  int selectedIndex;

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
                height: availableHeight,
                child: Column(
                  children: [
                    AppointmentForm(
                      formData: _formData,
                      form: _form,
                      isValidDate: _isValidDate,
                      isValidPatient: _isValidPatient,
                      isValidDoctor: _isValidDoctor,
                    ),
                    SizedBox(height: 15),
                    _selectSchedule(),
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
                    Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cancelButton(
                              context, () => Navigator.of(context).pop()),
                          // finishButton(context, _saveForm),
                          finishButton(context, () {}),
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
      final Appointment appointment =
          ModalRoute.of(context).settings.arguments as Appointment;
      if (appointment != null) {
        setState(() {
          _titleScreen = 'Editar Consulta';
        });
        _formData['id'] = appointment.id;
        _formData['patient'] = appointment.patient;
        _formData['doctor'] = appointment.doctor;
        _formData['schedule'] = appointment.schedule;
        _formData['result'] = appointment.result;
        _formData['certificate'] = appointment.certificate;
      }
    }
  }

  Widget _selectSchedule() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 0.7),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          // color: Colors.black12,
        ),
        child: ListView.builder(
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          itemCount: timeBlocks.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(8)),
                color: selectedIndex == index ? Colors.teal[50] : null,
              ),
              child: TextButton(
                autofocus: true,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    selectedIndex == index
                        ? Icon(
                            Icons.check_box_outlined,
                            color: Theme.of(context).accentColor,
                          )
                        : Icon(Icons.check_box_outline_blank,
                            color: Colors.black26),
                    const SizedBox(width: 10),
                    Text('Item: $index',
                        style: TextStyle(color: Theme.of(context).accentColor)),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
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
}
