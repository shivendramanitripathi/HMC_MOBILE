import 'package:flutter_mobile_arch/src/models/base_model/base_model.dart';
import 'package:g_json/g_json.dart';

class Country extends BaseModel {
  final String name;
  final String code;
  final String isoCode;

  Country({
    required this.name,
    required this.code,
    required this.isoCode,
  });

  Country.fromJson(JSON json)
      : name = json['name'].stringValue,
        code = json['code'].stringValue,
        isoCode = json['isoCode'].stringValue;

  @override
  JSON toJson() {
    return JSON({
      'name': name,
      'code': code,
      'isoCode': isoCode,
    });
  }
}
