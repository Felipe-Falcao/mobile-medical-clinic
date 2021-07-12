import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/doctor.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/models/specialty.dart';
import 'package:clinica_medica/providers/doctor/doctor_provider.dart';
import 'package:clinica_medica/widgets/doctor/forms/doctor_step_4.dart';
import 'package:clinica_medica/widgets/employee/employee_timeline.dart';
import 'package:clinica_medica/widgets/employee/forms/employee_step_1.dart';
import 'package:clinica_medica/widgets/employee/forms/employee_step_2.dart';
import 'package:clinica_medica/widgets/employee/forms/employee_step_3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:timelines/timelines.dart';

const todoColor = Color(0xffd1d2d7);

class RegisterDoctor extends StatefulWidget {
  const RegisterDoctor({Key key}) : super(key: key);

  @override
  _RegisterDoctorState createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  int _processIndex = 0;
  int _step = 1;
  final _formData = Map<String, Object>();
  final _form = GlobalKey<FormState>();
  bool isValidDate = true;
  String _title = 'Cadastrar Médico';
  bool _isEdit = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final Doctor doctor = ModalRoute.of(context).settings.arguments as Doctor;

      if (doctor != null) {
        setState(() {
          _title = 'Editar Médico';
          _isEdit = true;
        });

        _formData['id'] = doctor.id;
        _formData['crm'] = doctor.crm;
        _formData['salary'] = doctor.salary.toStringAsFixed(2);
        _formData['name'] = doctor.employee.name;

        _formData['employeeId'] = doctor.employee.id;
        _formData['phoneNumber'] = doctor.employee.phoneNumber;
        _formData['email'] = doctor.employee.email;
        _formData['cpf'] = doctor.employee.cpf;
        _formData['workCard'] = doctor.employee.workCard;
        _formData['hiringDate'] = doctor.employee.hiringDate;

        _formData['specialty_name'] = doctor.specialty.name;

        _formData['addressId'] = doctor.employee.address.id;
        _formData['street'] = doctor.employee.address.street;
        _formData['number'] = doctor.employee.address.number;
        _formData['zipCode'] = doctor.employee.address.zipCode;
        _formData['city'] = doctor.employee.address.city;
        _formData['state'] = doctor.employee.address.state;
      }
    }
  }

  void _nextStep() {
    var isValid = _form.currentState.validate();

    if (_step == 3) {
      setState(() {
        isValidDate = _formData['hiringDate'] != null;
      });
    }

    if (!isValid) return;
    setState(() {
      _step++;
      _processIndex = (_processIndex + 1) % 4;
    });
  }

  void _previousStep() {
    setState(() {
      _step--;
      _processIndex = (_processIndex - 1) % 4;
    });
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) return;

    _form.currentState.save();

    final address = Address(
        id: _formData['addressId'],
        street: _formData['street'],
        number: _formData['number'],
        zipCode: _formData['zipCode'],
        city: _formData['city'],
        state: _formData['state']);

    final specialty = Specialty(name: _formData['specialty_name']);

    final employee = Employee(
        id: _formData['employeeId'],
        workCard: _formData['workCard'],
        hiringDate: _formData['hiringDate'],
        email: _formData['email'],
        name: _formData['name'],
        phoneNumber: _formData['phoneNumber'],
        cpf: _formData['cpf'],
        password: _formData['password'],
        address: address);

    final doctor = Doctor(
        id: _formData['id'],
        crm: _formData['crm'],
        salary: double.parse(_formData['salary']),
        employee: employee,
        specialty: specialty);

    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);

    // print(doctor.toString());

    try {
      if (_formData['id'] == null) {
        doctorProvider.addDoctor(doctor);
      } else {
        doctorProvider.updateDoctor(doctor);
      }

      await showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Sucesso!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Divider()
                ],
              ),
              content: Text(
                'O Médico foi cadastrado com sucesso.',
                textAlign: TextAlign.center,
              ),
              actions: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff075B49)),
                          ),
                        )
                      ],
                    ))
              ],
            );
          });
      Navigator.of(context).pop();
    } catch (error) {
      // print(error);
      await showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 40,
                    color: Colors.red[400],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'O Médico não foi cadastrado!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Divider()
                ],
              ),
              content: Text(
                'Ocorreu um erro ao tentar salvar os dados do médico',
                textAlign: TextAlign.center,
              ),
              actions: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff075B49)),
                          ),
                        )
                      ],
                    ))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(_title),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_step == 1) {
              Navigator.of(context).pop();
            } else {
              _previousStep();
            }
          }),
    );

    List<String> _processes = [
      'Dados \nPessoais',
      'Endereço',
      'Dados \nTrabalhistas',
      'Dados \ndo Médico'
    ];

    return Scaffold(
        appBar: appBar,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: EmployeeTimeline(_processIndex, _processes),
                  ),
                  Container(
                    child: Column(
                      children: [
                        _step == 1
                            ? EmployeeStep1(_form, _formData, _isEdit)
                            : (_step == 2)
                                ? EmployeeStep2(_form, _formData)
                                : (_step == 3)
                                    ? EmployeeStep3(_form, _formData)
                                    : DoctorStep4(_form, _formData, _isEdit)
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 48,
                              width: 150,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (_step == 1) {
                                    Navigator.of(context).pop();
                                  } else {
                                    _previousStep();
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.all(16.0),
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    )),
                                child: Text(
                                  _step == 1 ? 'Cancelar' : 'Voltar',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              )),
                          SizedBox(
                              height: 48,
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(16.0),
                                    primary: Theme.of(context).accentColor),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(_step < 4
                                            ? 'Próximo'
                                            : 'Finalizar'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Icon(
                                          _step < 4
                                              ? Icons.arrow_forward
                                              : Icons.check,
                                          size: 19.0,
                                        ),
                                      ),
                                    ]),
                                onPressed: () {
                                  if (_step >= 1 && _step <= 3) {
                                    _nextStep();
                                  } else if (_step == 4) {
                                    _saveForm();
                                  }
                                },
                              ))
                        ],
                      )),
                ],
              )));
  }
}
