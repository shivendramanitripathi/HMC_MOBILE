import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeMapping on DateTime? {
  String get dateText {
    if (this == null) return '';
    return DateFormat('dd-MM-yyyy').format(this!);
  }

  String get timeText {
    if (this == null) return '';
    return DateFormat('hh:mm aa').format(this!);
  }

  String get monthText {
    if (this == null) return '';
    return DateFormat('MMMM').format(this!);
  }

  String get dateTimeText {
    if (this == null) return '';
    return DateFormat('dd-MM-yyyy hh:mm aa').format(this!);
  }

  TimeOfDay get timeOfDay {
    if (this == null) return TimeOfDay.now();
    return TimeOfDay(hour: this!.hour, minute: this!.minute);
  }
}
