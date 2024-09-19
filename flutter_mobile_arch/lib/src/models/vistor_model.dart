import 'package:hive/hive.dart';
part 'vistor_model.g.dart';

@HiveType(typeId: 0)
class Visitor {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  final String purpose;

  @HiveField(3)
  final String visitingDate;

  Visitor({
    required this.name,
    required this.phoneNumber,
    required this.purpose,
    required this.visitingDate,
  });
}
