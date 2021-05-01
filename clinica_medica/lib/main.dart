import 'package:clinica_medica/firebase/auth_connect.dart';
import 'package:clinica_medica/firebase/funcionario_connect.dart';
import 'package:clinica_medica/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'firebase/funcionario_connect.dart';

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
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }
  AuthenticationFB auth = new AuthenticationFB();

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
        stream:
            FirebaseFirestore.instance.collection('funcionario').snapshots(),
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
          // FuncionarioFB func = new FuncionarioFB();
          // var a = await func.read('23IfKpVrq7RLOzmunlDOCV9YQdu1');
          // print(a['nome']);

          // FirebaseFirestore.instance.collection('funcionario').add({
          //   'nome': 'TesteFlutter2',
          //   'email': 'testeflutter@teste',
          //   'carteiraTrabalho': 'teste',
          //   'telefone': '9999999',
          //   'dataContratacao': DateTime.now()
          // });
          // .snapshots()
          //     .listen((querySnapshot) {
          //   // print(querySnapshot.docs[0]['nome']);
          //   querySnapshot.docs.forEach((element) {
          //     print(element['nome']);
          //   });
          // });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
