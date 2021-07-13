import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/widgets/doctor/doctor_item.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classe que cria a tela onde são listados os médico
//e onde é feita a busca usando o filtro
class FindDoctor extends StatefulWidget {
  const FindDoctor({Key key}) : super(key: key);

  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  final _formData = Map<String, Object>();
  String _filter;

  @override
  Widget build(BuildContext context) {
    _filter = _formData['filter'];
    final DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context);
    final List<Doctor> doctors = doctorProvider.getItemsWith(_filter);

    final appBar = AppBar(
      title: Text('Médicos'),
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 90,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Icon(Icons.search_rounded),
                        right: 14,
                        top: 14,
                      ),
                      CustomTextFormField(
                        keyFormData: 'filter',
                        formData: _formData,
                        labelText: 'Digite o nome ou a especialidade',
                        onChanged: (value) {
                          setState(() {
                            _filter = value;
                          });
                        },
                      )
                    ],
                  )),
            ),
            Container(
                height: availableHeight - 90,
                child: ListView.builder(
                    itemBuilder: (context, int index) {
                      return DoctorItem(doctor: doctors[index]);
                    },
                    itemCount: doctors.length,
                    padding: EdgeInsets.only(left: 16.0, right: 16.0)))
          ],
        ),
      ),
    );
  }
}
