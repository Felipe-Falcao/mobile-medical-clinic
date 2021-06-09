import 'package:flutter/material.dart';

final ButtonStyle elevatedButtomStyle = ElevatedButton.styleFrom(
  primary: Color(0xFF001524),
  padding: EdgeInsets.all(16.0),
  minimumSize: Size(150, 48),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle outlinedButtomStyle = OutlinedButton.styleFrom(
  primary: Color(0xFF001524),
  padding: EdgeInsets.all(16.0),
  minimumSize: Size(150, 48),
  side: BorderSide(
    color: Color(0xFF72D5BF),
    width: 2,
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final appTheme = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xFF72D5BF),
  accentColor: Color(0xFF001524),
  backgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(centerTitle: true),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtomStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtomStyle),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color.fromRGBO(0, 21, 36, 0.11),
  ),
);
