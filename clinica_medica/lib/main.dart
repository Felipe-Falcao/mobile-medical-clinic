import 'package:clinica_medica/controllers/consulta_controller.dart';
import 'package:clinica_medica/controllers/endereco_controller.dart';
import 'package:clinica_medica/controllers/paciente_controller.dart';
import 'package:clinica_medica/controllers/prontuario_controller.dart';
import 'package:clinica_medica/infra/auth_connect.dart';
import 'package:clinica_medica/infra/funcionario_connect.dart';
import 'package:clinica_medica/models/consulta_data.dart';
import 'package:clinica_medica/models/paciente_data.dart';
import 'package:clinica_medica/models/prontuario_data.dart';
import 'package:clinica_medica/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clinica_medica/models/endereco_data.dart';
import 'package:clinica_medica/models/funcionario_data.dart';
import 'package:clinica_medica/models/medico_data.dart';
import 'package:clinica_medica/models/atendente_data.dart';
import 'package:clinica_medica/models/paciente_data.dart';
import 'package:clinica_medica/models/medicamento_data.dart';
//https://saveyourtime.medium.com/firebase-cloud-firestore-add-set-update-delete-get-data-6da566513b1b
import 'models/auth_data.dart';

import 'package:clinica_medica/controllers/funcionario_controller.dart';
import 'package:clinica_medica/controllers/medicamento_controller.dart';

bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthenticationFB auth = new AuthenticationFB();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integração Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
        accentColor: Colors.blueAccent,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      // home: AuthScreen(),
      home: StreamBuilder(
        stream: auth.isLogged(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return MyHomePage();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthenticationFB auth = new AuthenticationFB();
  FuncionarioFB func = new FuncionarioFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Integração Firebase'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Sair'),
                    ],
                  ),
                ),
              )
            ],
            onChanged: (item) {
              if (item == 'logout') {
                auth.signOut();
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        // READ ALL
        stream: func.readAll(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data;
          return ListView.builder(
            itemCount: documents.size,
            itemBuilder: (ctx, i) => Container(
              padding: EdgeInsets.all(10),
              child: Text(documents.docs[i]['nome']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          InfoEndereco infoEndereco = new InfoEndereco();
          infoEndereco.cep = '4900002';
          infoEndereco.cidade = 'Aracaju';
          infoEndereco.estado = 'SE';
          infoEndereco.logradouro = 'Rua Nova';
          infoEndereco.numero = '15';

          InfoFuncionario infoFuncionario = new InfoFuncionario();
          infoFuncionario.cpf = '000.000.000-00';
          infoFuncionario.email = 'testemedico@gmail.com';
          infoFuncionario.senha = '1234567';
          infoFuncionario.carteiraTrabalho = '32.165.4';
          infoFuncionario.dataContratacao = DateTime.now();
          infoFuncionario.nome = 'Teste Medico';
          infoFuncionario.telefone = '79 99999997';

          InfoMedico infoMedico = new InfoMedico();
          infoMedico.crm = '111.111.112';
          infoMedico.salario = '14000';
          infoMedico.nomeEspecialidade = 'Pediatra';

          InfoAtendente infoAtendente = new InfoAtendente();
          infoAtendente.salario = '3550';
          infoAtendente.turno = 'Manhã';

          InfoPaciente infoPaciente = new InfoPaciente();
          infoPaciente.cpf = '999.999.999-98';
          infoPaciente.dataNascimento = DateTime.now();
          infoPaciente.nome = 'Teste Paciente';
          infoPaciente.telefone = '(99) 9 9999-9998';

          InfoMedicamento infoMedicamento = new InfoMedicamento();
          infoMedicamento.dataPrescricao = DateTime.now();
          infoMedicamento.dose = '7 por dia';
          infoMedicamento.nome = 'Remédiso';

          InfoConsulta infoConsulta = new InfoConsulta();
          infoConsulta.data = DateTime.now();

          InfoProntuario infoProntuario = new InfoProntuario();
          infoProntuario.nota = 'Medicamento receitado. Dor de barriga.';
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
