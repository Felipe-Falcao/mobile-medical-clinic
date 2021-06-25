import 'package:flutter/cupertino.dart';

class Schedule {
  DateTime date;
  String timeBlock;

  Schedule({
    @required this.date,
    @required this.timeBlock,
  });
}

class TimeBlock {
  static const H8M00 = '8:00';
  static const H8M30 = '8:30';
  static const H9M00 = '9:00';
  static const H9M30 = '9:30';
  static const H10M00 = '10:00';
  static const H10M30 = '10:30';
  static const H11M00 = '11:00';
  static const H11M30 = '11:30';
  static const H12M00 = '12:00';
  static const H12M30 = '12:30';
  static const H13M00 = '13:00';
  static const H13M30 = '13:30';
  static const H14M00 = '14:00';
  static const H14M30 = '14:30';
  static const H15M00 = '15:00';
  static const H15M30 = '15:30';
  static const H16M00 = '16:00';
  static const H16M30 = '16:30';
  static const H17M00 = '17:00';
  static const H17M30 = '17:30';
}
