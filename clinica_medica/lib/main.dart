import 'package:clinic_app_01/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xff72D5BF),
      accentColor: Colors.black
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
     Duration(seconds: 3
     ), () {
       Navigator.push(
         context, 
         MaterialPageRoute(
           builder: (context) => Login()
         )
         );
     }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 350),
        child: Image.asset('assets/images/logo02.png'),
      ),
      backgroundColor: Color(0xff72D5BF),
    );
  }
}