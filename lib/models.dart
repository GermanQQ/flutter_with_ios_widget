import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetData {
  final DateTime dayMonth;
  final EventType type;
  final String name;

  WidgetData({required this.name, required this.dayMonth, required this.type});

  String get dayMonthStr => "${dayMonth.day}/${dayMonth.monthWithZero}";

  String passJsonToNative() => jsonEncode({
        'dayMonth': dayMonthStr,
        'time': dayMonth.timeFormatWidget,
        'type': type.getStringType,
        'name': name,
      });
}

extension MonthDay on DateTime {
  String get monthWithZero {
    if (month < 10) {
      return '0$month';
    }
    return '$month';
  }

  String get timeFormatWidget {
    return DateFormat.jm().format(this);
  }
}

enum EventType { call, meeting, conference, none }

extension EventExtension on EventType {
  String get getStringType {
    switch (this) {
      case EventType.call:
        return 'call';
      case EventType.meeting:
        return 'meeting';
      case EventType.conference:
        return 'conference';
      default:
        return 'none';
    }
  }

  IconData get eventIcon {
    switch (this) {
      case EventType.meeting:
        return Icons.people;
      case EventType.call:
        return Icons.call;
      case EventType.conference:
        return Icons.event;
      default:
        return Icons.event;
    }
  }

  Color get eventColor {
    switch (this) {
      case EventType.meeting:
        return Colors.indigo;
      case EventType.call:
        return Colors.purpleAccent;
      case EventType.conference:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

extension StringEventExtension on String {
  EventType get getStringType {
    switch (this) {
      case 'call':
        return EventType.call;
      case 'meeting':
        return EventType.meeting;
      case 'conference':
        return EventType.conference;
      default:
        return EventType.none;
    }
  }
}
