import 'package:flutter/material.dart';

class Job {
  final String title;
  final IconData icon;

  Job(this.title, this.icon);

  @override
  String toString() {
    return title;
  }
}
