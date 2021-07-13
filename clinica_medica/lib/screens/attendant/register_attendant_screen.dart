import 'package:clinica_medica/models/address.dart';
import 'package:clinica_medica/models/attendant.dart';
import 'package:clinica_medica/models/employee.dart';
import 'package:clinica_medica/providers/attendant/attendant_provider.dart';
import 'package:clinica_medica/widgets/attendant/forms/attendant_step4.dart';
import 'package:clinica_medica/widgets/employee/employee_timeline.dart';
import 'package:clinica_medica/widgets/employee/forms/employee_step_1.dart';
import 'package:clinica_medica/widgets/employee/forms/employee_step_2.dart';
import 'package:clinica_medica/widgets/employee/forms/employee_step_3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classe que cria a Tela de cadastro de atendente
class RegisterAttendantScreen extends StatefulWidget {
  const RegisterAttendantScreen({Key key}) : super(key: key);

  @override
  _RegisterAttendantScreenState createState() =>
      _RegisterAttendantScreenState();
}

class _RegisterAttendantScreenState extends State<RegisterAttendantScreen> {
  int _processIndex = 0;
  int _step = 1;
  final _formData = Map<String, Object>();
  final _form = GlobalKey<FormState>();
  bool isValidDate = true;
  String _title = 'Cadastrar Atendente';
  bool _isEdit = false;
  bool _isLoading = false;

  //função nativa do flutter que está sendo usada
  //para verficar se algum dado foi enviado
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final Attendant attendant =
          ModalRoute.of(context).settings.arguments as Attendant;

      if (attendant != null) {
        setState(() {
          _title = 'Editar Atendente';
          _isEdit = true;
        });

        _formData['id'] = attendant.id;
        _formData['rotation'] = attendant.rotation;
        _formData['salary'] = attendant.salary.toStringAsFixed(2);

        _formData['employeeId'] = attendant.employee.id;
        _formData['name'] = attendant.employee.name;
        _formData['phoneNumber'] = attendant.employee.phoneNumber;
        _formData['email'] = attendant.employee.email;
        _formData['cpf'] = attendant.employee.cpf;
        _formData['workCard'] = attendant.employee.workCard;
        _formData['hiringDate'] = attendant.employee.hiringDate;

        _formData['addressId'] = attendant.employee.address.id;
        _formData['street'] = attendant.employee.address.street;
        _formData['number'] = attendant.employee.address.number;
        _formData['zipCode'] = attendant.employee.address.zipCode;
        _formData['city'] = attendant.employee.address.city;
        _formData['state'] = attendant.employee.address.state;
      }
    }
  }

  //função que avança uma etapa no cadastro
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

  //função que volta para a etapa anterior do cadastro
  void _previousStep() {
    setState(() {
      _step--;
      _processIndex = (_processIndex - 1) % 4;
    });
  }

  //função que salva o formulário de cadastro de atendente
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

    final attendant = Attendant(
        id: _formData['id'],
        employee: employee,
        salary: double.parse(_formData['salary']),
        rotation: _formData['rotation']);

    final attendantProvider =
        Provider.of<AttendantProvider>(context, listen: false);

    try {
      if (_formData['id'] == null) {
        attendantProvider.addAttendant(attendant);
      } else {
        attendantProvider.updateAttendant(attendant);
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
                'O Atendente foi cadastrado com sucesso.',
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
                    'Houve um erro ao tentar cadastrar o atendente!',
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
      'Dados \ndo Atendente'
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
                                    : AttendantStep4(_form, _formData, _isEdit)
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
