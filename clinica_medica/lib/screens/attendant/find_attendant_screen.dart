import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/widgets/attendant/attendant_item.dart';
import 'package:clinica_medica/widgets/employee/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classe que cria a tela onde são listados os antendentes
//e onde é feita a busca usando o filtro
class FindAttendantScreen extends StatefulWidget {
  const FindAttendantScreen({Key key}) : super(key: key);

  @override
  _FindAttendantScreenState createState() => _FindAttendantScreenState();
}

class _FindAttendantScreenState extends State<FindAttendantScreen> {
  final _formData = Map<String, Object>();
  String _filter;
  @override
  Widget build(BuildContext context) {
    _filter = _formData['filter'];

    final AttendantProvider attendantProvider =
        Provider.of<AttendantProvider>(context);
    final List<Attendant> attendants = attendantProvider.getItemsWith(_filter);

    final appBar = AppBar(
      title: Text('Atendentes'),
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
                        labelText: 'Digite um nome',
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
                      return AttendantItem(attendant: attendants[index]);
                    },
                    itemCount: attendants.length,
                    padding: EdgeInsets.only(left: 16.0, right: 16.0)))
          ],
        ),
      ),
    );
  }
}
