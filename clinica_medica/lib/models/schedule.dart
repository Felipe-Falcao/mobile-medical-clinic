import 'package:flutter/cupertino.dart';

class Schedule {
  DateTime date;
  String timeBlock;

  Schedule({
    @required this.date,
    @required this.timeBlock,
  });
}

List<String> timeBlocks = [
  '8:00',
  '8:30',
  '9:00',
  '9:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14:00',
  '14:30',
  '15:00',
  '15:30',
  '16:00',
  '16:30',
  '17:00',
  '17:30'
];
