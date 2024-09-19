import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/vistor_model.dart';

class VisitorProvider with ChangeNotifier {
  final Box<Visitor> _visitorBox = Hive.box<Visitor>('visitors');
  String _name = '';
  String _phoneNumber = '';
  String _purpose = 'Interview';
  DateTime _visitingDate = DateTime.now();

  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get purpose => _purpose;
  String get visitingDate => _visitingDate.toString().split(' ')[0];

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updatePurpose(String purpose) {
    _purpose = purpose;
    notifyListeners();
  }

  void updateVisitingDate(DateTime date) {
    _visitingDate = date;
    notifyListeners();
  }

  Future<void> saveVisitor() async {
    final visitor = Visitor(
      name: _name,
      phoneNumber: _phoneNumber,
      purpose: _purpose,
      visitingDate: visitingDate,
    );

    await _visitorBox.add(visitor);
    notifyListeners();
  }

  List<Visitor> getAllVisitors() {
    return _visitorBox.values.toList();
  }
}
